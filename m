Return-Path: <linux-kernel+bounces-895729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 626FDC4EC9A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2E724E668A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B2364EBA;
	Tue, 11 Nov 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PTZEZTSn"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705E342506
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874838; cv=none; b=g7nlqtuEsj00OvkJAtEl7qgnlXWZjYHO0tDXtL1WVUKn+7Gvagb8Hscku5Traoq6fw7l07ZChz+GPNSwr7ia3G1lYTs4sk0eJpWBrHPag1b45RcJjnBtVPXwM4L3Y5Nm16vSMX2/pPXJwcFEU5nGCgz3mKF+SQn2V0UEtaZ6U2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874838; c=relaxed/simple;
	bh=PjuUe7S5bPhZhXrloLvrqW3sQkxav5Rx2DdTVOyx5eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mv6KvFsKB7t9ki0Pb0jBnX1r0ej3NYR+mnUtQCAVmq4OXWqiiol/UjtrAo0JFvuYepMCRrai035NRwuINTUkwaJ8retrQxdm30JQH217HKVBcDpBEakm/uxnwKucbI1hUCKmddSqaKCn3b5fsXCGrvZgvu3dKGs7ilPuuwGA0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=PTZEZTSn; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso7380875a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762874834; x=1763479634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu6xqedUZpu06tEFPTZgP8w+N6x8oJvOkAJiVTdokuU=;
        b=PTZEZTSnCJUE91ItWsVCCL0TUsyRRnCFW0qXSQq8CIILQWtOpkkxwGHeO+pSltacIt
         5GYs6z1npHWpssoJ+XT0v10kxmwqtYOcsqgoAAKNuEBtxMEj0uMoRY+gOGoXouMrKGs8
         y4ALzzrZ8+JtJFBxNBt+QhP3AsRwQAokFf+zSEluvuwnBX99voS8gAAt+faO2OmmvPO1
         po1cZTJBTOEr2yuQyOZ/maYuJ6geONlZ777Pl/TnX/Yg2VT9U2Z5SRmXShDDRmb3Bf2W
         ugkcrEZsz8dAEIV90eQxWzQlQuYRmgrIo/St+FmYk+xvIev6TJMNCN5/YGgMuJQLs4Re
         MXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874834; x=1763479634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lu6xqedUZpu06tEFPTZgP8w+N6x8oJvOkAJiVTdokuU=;
        b=ve9MOq6bZvstnpK3SUJK88YRBDE7SwEbWtUzd24Yhj3Cffn0CMtoKe5KhegsJuH+QL
         M4dDmPfNS5Y8lhaI9djJCJRTqKFQQmsemrVNyCnug0VZqAMhMztraN9+8uxDvCdD16Ez
         O6kOen1c5y+ejRW1uxuS2yv/vPL70H/wCUOp/O4XxTAIRxEt8xI8Xyshh4JTCnLlAW6s
         ZlAp1Upafrw1e474+Nk3ObTv/cm1DkXidrbPhaJjnAlNIJAvd5U+uC/E6VPADOtXZktg
         54n4ZBE4dr4e7tHGTiOHejINhLy6iDQBOdU+qFuDX+hg3VgU8uuLnYIycyqSb7ph/rl+
         GHaw==
X-Forwarded-Encrypted: i=1; AJvYcCUQsj9/JjNRT1Z0a1CjA1WfO5mnSfBGO1KH75rDWDovsTX0+6HTr/HRdMAn0URZVU4P8R3uJtejEJWEiwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhCscSUmsUIpwbH333PBoKIm+c5ut4KkxC+Mmnyws/mABjWIr
	LYHJgLji/v1x/+QOhRwsUc359bJt6U/EaxHzEF2gGD2wAEDbgi6FzZST49MeD2jd/PPwFIPu4W9
	gR+Xw+kPumQ1RkGAwucaLn6towqFy4srMXCJYCPrhog==
X-Gm-Gg: ASbGncu+4D4L8DRsa0/CYEe4kPAZVknMaSX88v+heQcxEBsZTdM0j1pCbwH3ZdEWA/m
	j6OelrAFzaL05bBoEiphFfvYlGY9e/TcQLCgD+tBEKVCM45vXYpmnJogzlK3YH3ODnHumaXNWE9
	DXK+BxsFB2JLaroCFmlVxTwxo1ytYviKm4xTkDgsjWMOgWdgjQA1i7ApN7VvP4yKsoFpW+IXs6y
	4gpBXY1YnaPAOTliVlEiV3/D5Q6rFe0IWBjIiSiyxEUXjJyPwOnCBVTMw==
X-Google-Smtp-Source: AGHT+IGfpzw30I50uzhP4zU1mSQ9H6EkikBegZxPU5LLVKtN3RM+oen2ff0GDhVd9BnhapB0BApwf174qkOpARMYJRI=
X-Received: by 2002:a05:6402:2688:b0:640:c3c4:45fd with SMTP id
 4fb4d7f45d1cf-6415dc00b0bmr10748897a12.5.1762874834355; Tue, 11 Nov 2025
 07:27:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com> <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
 <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
 <CA+CK2bC_+repP-q183hjAuYYB2-Yx7fr_U3zr2cxysAWx5hzpg@mail.gmail.com>
 <029090cf-9a4d-4f79-b857-04c3ada83323@linux.dev> <CA+CK2bByYPJXSNOh6R3swqFrGsS02m3Dfh=ZU7YhNjNX6siyqg@mail.gmail.com>
 <442fa82e-16ef-4bde-84eb-743450222468@linux.dev> <mafs0qzu69gei.fsf@kernel.org>
 <CA+CK2bBEe16x0em1gRxQD3jhfV9t3QA2vx5ifk2pKb_WEoMTeg@mail.gmail.com> <0735e1ef-2b65-4a54-b4d5-964fb875cd09@linux.dev>
In-Reply-To: <0735e1ef-2b65-4a54-b4d5-964fb875cd09@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 11 Nov 2025 10:26:38 -0500
X-Gm-Features: AWmQ_bnTJun9_-b7oKykqWTYNLwDN30PScTynxGQ0sII17gfGixQqv4sWCWauz0
Message-ID: <CA+CK2bBnnGyQ-N8-XS3W3tnSRwvFbstOdo0oDSdkF70KP1AVxw@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:11=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> =
wrote:
>
> In FC42, when I run "./luo_multi_session"
>
> # ./luo_multi_session
> # [STAGE 1] Starting pre-kexec setup for multi-session test...
> # [STAGE 1] Creating state file for next stage (2)...
> # [STAGE 1] Creating empty sessions 'multi-test-empty-1' and
> 'multi-test-empty-2'...
> # [STAGE 1] Creating session 'multi-test-files-1' with one memfd...
> # [STAGE 1] Creating session 'multi-test-files-2' with two memfds...
> # [STAGE 1] Executing kexec...
>
> Then the system hang. And via virt-viewer, a calltrace will appear.

Looks like mountroot fails, are you passing the same kernel parameters
as the during cold boot?
i.e. kexec -l -s --reuse-cmdline --initrd=3D[initramfs] [kernel]

Pasha

>
> The call trace is in the attachment.
>
> Yanjun.Zhu
>
> =E5=9C=A8 2025/11/10 7:26, Pasha Tatashin =E5=86=99=E9=81=93:
> > On Mon, Nov 10, 2025 at 8:16=E2=80=AFAM Pratyush Yadav <pratyush@kernel=
.org> wrote:
> >> On Sun, Nov 09 2025, Zhu Yanjun wrote:
> >>
> >>> =E5=9C=A8 2025/11/8 10:13, Pasha Tatashin =E5=86=99=E9=81=93:
> >>>> On Fri, Nov 7, 2025 at 6:36=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.=
dev> wrote:
> >>>>> On 11/7/25 4:02 AM, Pasha Tatashin wrote:
> >>>>>> On Fri, Nov 7, 2025 at 7:00=E2=80=AFAM Pasha Tatashin <pasha.tatas=
hin@soleen.com> wrote:
> >>>>>>>> Hi, Pasha
> >>>>>>>>
> >>>>>>>> In our previous discussion, we talked about counting the number =
of times
> >>>>>>>> the kernel is rebooted via kexec. At that time, you suggested ad=
ding a
> >>>>>>>> variable in debugfs to keep track of this count.
> >>>>>>>> However, since debugfs is now optional, where would be an approp=
riate
> >>>>>>>> place to store this variable?
> >>>>>>> It is an optional config and can still be enabled if the live upd=
ate
> >>>>>>> reboot number value needs to be accessed through debugfs. However=
,
> >>>>>>> given that debugfs does not guarantee a stable interface, tooling
> >>>>>>> should not be built to require these interfaces.
> >>>>>>>
> >>>>>>> In the WIP LUO [1] I have, I pr_info() the live update number dur=
ing
> >>>>>>> boot and also store it in the incoming LUO FDT tree, which can al=
so be
> >>>>>>> accessed through this optional debugfs interface.
> >>>>>>>
> >>>>>>> The pr_info message appears like this during boot:
> >>>>>>> [    0.000000] luo: Retrieved live update data, liveupdate number=
: 17
> >>>>>>>
> >>>>>>> Pasha
> >>>>>> Forgot to add link to WIP LUOv5:
> >>>>>> [1] https://github.com/soleen/linux/tree/luo/v5rc04
> >>>>> Thanks a lot. I=E2=80=99ve carefully read this commit:
> >>>>> https://github.com/soleen/linux/commit/60205b9a95c319dc9965f119303a=
1d83f0ff08fa.
> >>>>>
> >>>>> To be honest, I=E2=80=99d like to run some tests with who/luo, incl=
uding the
> >>>>> selftest for kho/luo. Could you please share the steps with me?
> >>>>>
> >>>>> If the testing steps have already been documented somewhere, could =
you
> >>>>> please share the link?
> >>>> Currently the test performs in-kernel tests for FLB data, it creates=
 a
> >>>> number of FLB for every registered LUO file-handler, which at the
> >>>> moment is only memfd.
> >>>>
> >>>> It works together with any of the kexec based live update tests. In
> >>>> v5, I introduce two tests:
> >>>> luo_kexec_simple
> >>>> luo_multi_session
> >>>>
> >>>> For example, with luo_multi_session:
> >>> Hi, Pasha
> >>>
> >>> I enabled "CONFIG_LIVEUPDATE=3Dy"
> >>>
> >>> # ./luo_multi_session
> >>> 1..0 # SKIP Failed to open /dev/liveupdate. Is the luo module loaded?
> >>>
> >>> # ls /dev/liveupdate
> >>> ls: cannot access '/dev/liveupdate': No such file or directory
> >>>
> >>> # grep "LIVEUPDATE" -inrHI /boot/config-`uname -r`
> >>> /boot/config-next-20251107-luo+:349:CONFIG_LIVEUPDATE=3Dy
> >>> /boot/config-next-20251107-luo+:11985:CONFIG_LIVEUPDATE_TEST=3Dy
> >>>
> >>> I made tests on FC42. But /dev/liveupdate is missing.
> >> You need to add liveupdate=3D1 to your kernel cmdline to enable LUO an=
d
> >> get /dev/liveupdate.
> > +1, kernel parameters require: kho=3D1 liveupdate=3D1
> >
> >> Pasha, your LUO series doesn't add the liveupdate parameter to
> >> kernel-parameters.txt. I think it should be done in the next version t=
o
> >> this parameter is discoverable.
> > Yeah, that is missing, I will update that in a standalone patch, or in
> > a next version.
> >
> > Thanks,
> > Pasha
>
> --
> Best Regards,
> Yanjun.Zhu

