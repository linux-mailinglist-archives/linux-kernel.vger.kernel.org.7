Return-Path: <linux-kernel+bounces-893497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAAAC478BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1004B18841F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C338B24E4AF;
	Mon, 10 Nov 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Nl4Gl5OE"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F85223D2B1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788447; cv=none; b=ReTwoH/re/j7mxV9J953Wtq8NrPHIo9ggtXqWtlIRjijsSJYrRPrsqijZW0p1rGRM4LTmhrbidSz/WNSo5cLHLQBwPb9U4yGa7PBcMnu1rAP+c+f9xX/Yt8pi5MZgq3xY0W45gwBkh9Je3Ji9Een1KOvogAzAe5nZfUfoR/LCT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788447; c=relaxed/simple;
	bh=tTrwyqMXKGOusM8XR8JCOt9JF5xyhgL7Lhk3o4N59YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsVcuWNPMu0vAhcjJsnE+Kr/OK7R/IYQCblQi8Fq0FNjmFW/VhzTirsHHHxFLERJ0xin9WsLsLpz3cU7SKNpsm9RctgQAUvlfRcmVc8QnDeykVTfnwI8U2htAeHnw4JeZMiE/1Xou1+eDJzZFtVwA8yO23bPY74FnijAXVp3624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Nl4Gl5OE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so5422160a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762788443; x=1763393243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xx5VH4vrYCNCYpVzx/bKqrzvT5nCviGfQ8I1/CSh6+0=;
        b=Nl4Gl5OE9iAy2SFBh7TKwjJiL6RnNxRn+CjzmE0AvQNEeqIhWihGv3XIqfAQWjIMe2
         r3jTOtc2g4bdkBSlpdN9oGTMO+TPtaHNZkNYhc+4wFD5BU6Y0pafCUK8WUJGx4UumWHp
         zGxqvDrHei8EJlKNOfKJvxqnNQZV330pryuuz5lDaCe34rsaPpyd9rCZE07oAxJ9gd0t
         fyJMY+dAy7YT52D6VQd+308G+Y4nI+rXiiaT8TlxknKzKJhLoRr1NKw8tVl/1xTHF+bG
         IbJX3VZAh5h/MLdTz1B0WyWljiLeiE1I7OcATfWm0+L3L7NX1r3orf5EAt3/9AY1DcpV
         L9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788443; x=1763393243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xx5VH4vrYCNCYpVzx/bKqrzvT5nCviGfQ8I1/CSh6+0=;
        b=jjgH7FvFCHac7TMA7jtaneEm8Tkb5Vu9mrKrppNrhrjPMa1tMh5Vnm89WxnCqVLE6o
         hhMyMgca14hiZBcz9P2zAv8xuPaAA0c9p1vwjJBng/wzT1Fas6UGhtEKvZ26RqEgHEWP
         CjNZr+u+IF63oK4DnN4nOjs0M0Tvnth3B5YcORIYjQ+FN4muVZdJyua0NuUWclYj2KVo
         U3fXrXMLk3ikgodoas6KVhO4vYjbsQli3duCwITDpum+mEz0mfMsm89ZkmuS6zXyp02j
         V0j21NcbD69L5lbyC+q50H+obvYs4kNbz5RhqPwykdp93fBcA/HhN+IWr3eG1OkDZlvD
         /SSg==
X-Forwarded-Encrypted: i=1; AJvYcCVq6vhF8ERmGuphgcn2QZHQtNvh06Ubt6fqfXe7QcDgCPV0ARHm6HCzUqTPXdTVUwA5ALUhVbhliQzw5wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQgjEikn5eTqOV0ZIo4dYHk5KX6fl+rYM+0Ks6CtHFxkGqnkkH
	nnhBoqXuhK2qmjAU35wM1DbdPsTPal1nOG/NazxVnCC3ilUxYXiwJj86Zkve26B8G3nqfWw5J/t
	bSvg+61PJgDLJrSHWtxjvu7bvX/RnAJD7FxW/tZGRMg==
X-Gm-Gg: ASbGncuAcWeEw8ZHanOZQnDpHpdIyUD7Xgw64OCKxW9FTnU8g1rHvbz75t1bGeApdIL
	EjnF8UxOvby5PYAoAtR8GY8pR64XdWUn6cep0Eywjz7pE3Rfy2Wmo0leDnm0L9eewbFg/PkNbIH
	uEDUKHO2AE2slF6KVzTo0kDf7YDG5HcIkKFUD+PYJbI1aq23OspiMeQ8fdvrkL7ZhXEC0uBbiCG
	whRlukqowPOLxiTV3CRNNKPi6uhVEv9BbzfdwFwKY7WZ/whKCFdc1zL//I15NtBkXuN
X-Google-Smtp-Source: AGHT+IH3MMnfCX6a3z6KUPljUpeObG5OPDBsINyyjGmXqmi/rDT84EI39PSGtuUazEgx1PPu0eGaSKu77yp++hDXvLE=
X-Received: by 2002:a05:6402:2813:b0:640:9bb0:a059 with SMTP id
 4fb4d7f45d1cf-6415a078158mr7201302a12.10.1762788442919; Mon, 10 Nov 2025
 07:27:22 -0800 (PST)
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
In-Reply-To: <mafs0qzu69gei.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 10 Nov 2025 10:26:46 -0500
X-Gm-Features: AWmQ_bmW_CU-wm8DFynzZQ_qvdh98IjjlGR3MaYCYIdL41bju3LuBNxGSfrd-pM
Message-ID: <CA+CK2bBEe16x0em1gRxQD3jhfV9t3QA2vx5ifk2pKb_WEoMTeg@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 8:16=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Sun, Nov 09 2025, Zhu Yanjun wrote:
>
> > =E5=9C=A8 2025/11/8 10:13, Pasha Tatashin =E5=86=99=E9=81=93:
> >> On Fri, Nov 7, 2025 at 6:36=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.de=
v> wrote:
> >>>
> >>> On 11/7/25 4:02 AM, Pasha Tatashin wrote:
> >>>> On Fri, Nov 7, 2025 at 7:00=E2=80=AFAM Pasha Tatashin <pasha.tatashi=
n@soleen.com> wrote:
> >>>>>> Hi, Pasha
> >>>>>>
> >>>>>> In our previous discussion, we talked about counting the number of=
 times
> >>>>>> the kernel is rebooted via kexec. At that time, you suggested addi=
ng a
> >>>>>> variable in debugfs to keep track of this count.
> >>>>>> However, since debugfs is now optional, where would be an appropri=
ate
> >>>>>> place to store this variable?
> >>>>> It is an optional config and can still be enabled if the live updat=
e
> >>>>> reboot number value needs to be accessed through debugfs. However,
> >>>>> given that debugfs does not guarantee a stable interface, tooling
> >>>>> should not be built to require these interfaces.
> >>>>>
> >>>>> In the WIP LUO [1] I have, I pr_info() the live update number durin=
g
> >>>>> boot and also store it in the incoming LUO FDT tree, which can also=
 be
> >>>>> accessed through this optional debugfs interface.
> >>>>>
> >>>>> The pr_info message appears like this during boot:
> >>>>> [    0.000000] luo: Retrieved live update data, liveupdate number: =
17
> >>>>>
> >>>>> Pasha
> >>>> Forgot to add link to WIP LUOv5:
> >>>> [1] https://github.com/soleen/linux/tree/luo/v5rc04
> >>>
> >>> Thanks a lot. I=E2=80=99ve carefully read this commit:
> >>> https://github.com/soleen/linux/commit/60205b9a95c319dc9965f119303a1d=
83f0ff08fa.
> >>>
> >>> To be honest, I=E2=80=99d like to run some tests with who/luo, includ=
ing the
> >>> selftest for kho/luo. Could you please share the steps with me?
> >>>
> >>> If the testing steps have already been documented somewhere, could yo=
u
> >>> please share the link?
> >> Currently the test performs in-kernel tests for FLB data, it creates a
> >> number of FLB for every registered LUO file-handler, which at the
> >> moment is only memfd.
> >>
> >> It works together with any of the kexec based live update tests. In
> >> v5, I introduce two tests:
> >> luo_kexec_simple
> >> luo_multi_session
> >>
> >> For example, with luo_multi_session:
> >
> > Hi, Pasha
> >
> > I enabled "CONFIG_LIVEUPDATE=3Dy"
> >
> > # ./luo_multi_session
> > 1..0 # SKIP Failed to open /dev/liveupdate. Is the luo module loaded?
> >
> > # ls /dev/liveupdate
> > ls: cannot access '/dev/liveupdate': No such file or directory
> >
> > # grep "LIVEUPDATE" -inrHI /boot/config-`uname -r`
> > /boot/config-next-20251107-luo+:349:CONFIG_LIVEUPDATE=3Dy
> > /boot/config-next-20251107-luo+:11985:CONFIG_LIVEUPDATE_TEST=3Dy
> >
> > I made tests on FC42. But /dev/liveupdate is missing.
>
> You need to add liveupdate=3D1 to your kernel cmdline to enable LUO and
> get /dev/liveupdate.

+1, kernel parameters require: kho=3D1 liveupdate=3D1

>
> Pasha, your LUO series doesn't add the liveupdate parameter to
> kernel-parameters.txt. I think it should be done in the next version to
> this parameter is discoverable.

Yeah, that is missing, I will update that in a standalone patch, or in
a next version.

Thanks,
Pasha

