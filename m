Return-Path: <linux-kernel+bounces-860186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C653BEF898
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26B99348711
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29392DCF4C;
	Mon, 20 Oct 2025 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdtgZxUD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E02DE71B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943360; cv=none; b=MsSHU6LkXNxcdfbqWACteCKwCsLez7AEi5KSsLFvZz0HaWz0GwSxAIPp9pNhjClulMFDboxJ3UVU6qH/S5GxrxS66lcwasUw+YogNu3RWta6YT8v2EC1k8hatbBrQgLt8dnggBxaz02U7hzpU1GTG8D8xWZHK93EEHJPM6DwGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943360; c=relaxed/simple;
	bh=gjo/6Sjyy4wzQdCVDI4toDbmg3rq4WBazYvMUGXP+aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SExClv6hSUIr4C3FLsJhTYIkQsjHJZxgCy2UcdejJIumyKNKnU0NUZP/8Yb4aWJemtbgUHupsR3jJgqVF+TntbaZkL5Vzw/mrHSAsxQZyQt7RnqiPNSr/2ITe+ef4BQGG7febPx7nQ+v1zg21Nl5SBI4WzNLPEFRlWr+qx4Q3go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdtgZxUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF3CC16AAE
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760943360;
	bh=gjo/6Sjyy4wzQdCVDI4toDbmg3rq4WBazYvMUGXP+aM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CdtgZxUDHqA2aG2niIUkozRqTfns5dsoCNeI5jiz0zWkdjP9k7J7ewWaMO8m+XKNT
	 zuEtqYS65zfSD0GX2zxkVJBSYAR3n9y3JlQMYKx2kvHJq2zFzVw/IH4YIIBL7Ik1DD
	 /d5420m7wiKxJOB3PnIFRRnn6j44dIecWPVCSBX/s+OndLN/lFYIkgLwJPTcF4CVxi
	 oekdb803Eg//VM7GtyIpjXTMV6w0kxQzizo+/se33MY5vjF6Tsjga7sxRh8HI29VDg
	 p+WuOYuSdB2YccObHd5SRnP83qU0B14HXM9lW7q75WqM6otBQ52pk9KLVCho5NHodS
	 vGSlNUB2Hxv/g==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso7316596a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:56:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOwnC278/3Z7xajZo4r0HJBlGfV3YGeUutzpb6TR4E8Py2pjfigBLr6zTt4UXxAwk1oTTDyD0lm8VT+6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyaz7FGPGSc9t4ZNRgJTiwPtN2qWUXdl5xzTLOev5pvqeL2Zyr
	IIe++Cbx3FqP4/Fd9YkqffkyrSxZ1uE0+xdgCQYt1t4AhSZNrfmkq+q8CywdpmOXTjxrDz6GOYd
	7VPzXa1syopQjycJrIqQZMVS/vAc5Ujs=
X-Google-Smtp-Source: AGHT+IFnfhUn8HN0p4pAoHDFb320UnHrLwc6eiuN03fPNFETWItVQO870cPTacL3OdFj5V/dRgq1RI8aSYi1eCsoLeg=
X-Received: by 2002:a05:6402:13ca:b0:634:5297:e3bc with SMTP id
 4fb4d7f45d1cf-63c1f629a40mr12798466a12.6.1760943359107; Sun, 19 Oct 2025
 23:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhV-H7HN128du-b1Rk_9qbYBq7gMSwo0s31909N4pTou6wzew@mail.gmail.com>
 <CAMj1kXGvSnCMRVCW7eAxgLRWMEV3QRj3Dqg3PmZchZJNpnLK9w@mail.gmail.com>
 <CAAhV-H4UKdso0BokAqvjYeBLr-jbjFAaQX4z=1ztpBamqrOEEg@mail.gmail.com>
 <CAMj1kXEXDC_oq4aWbkR5dqYBix2d1xJEdaj-v747e1nOA0Q_Yg@mail.gmail.com>
 <rhnei6wovxmoqs36wdysomfsul3faxtmgde73wrrqdt3qo3b2j@akd7vzne76rq>
 <CAMj1kXF+hDJy0vRWNgwoijHxvA-scvhGODMj9A3dv19v3jf2yw@mail.gmail.com>
 <lgyzruqczm7uti2lfbhfhr5hyzpnm7wtvgffa2o7nigx76g6i3@wlffltvmhhez>
 <CAMj1kXFDquPxCYSBWgjikS=209pSJ_kth67M0RDeuetV9CPYAw@mail.gmail.com>
 <wlx6pt5crtfdwtop4w5vjznjfarrwitq44wdbufncjdvtsx647@tgobruak66yb>
 <CAMj1kXFfEBkcc-aiwGrRR-pKg4LBbS7weK0pEpZJsKOk5pbkuA@mail.gmail.com>
 <jxfb5a2c2qber623l2gwewirwod54bbgfnvt7t7f3jah2ea33g@2uyhy3auzmpx> <d9f3352a-1c1f-464a-a8fd-741cd96b5f8e@loongson.cn>
In-Reply-To: <d9f3352a-1c1f-464a-a8fd-741cd96b5f8e@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 20 Oct 2025 14:55:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com>
X-Gm-Features: AS18NWDRalCHnTxlUVVh6Sc0-5BD00KgUctbRu4OmtnXD3m7UgQt5e4S4nAWM6E
Message-ID: <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, loongarch@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 9:24=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Hi Josh, Ard and Huacai,
>
> On 2025/10/18 =E4=B8=8A=E5=8D=881:05, Josh Poimboeuf wrote:
>
> ...
>
> > But IIUC, the libstub code runs *very* early, and wouldn't show up in a
> > stack trace anyway, because there are no traces of it on the stack once
> > it branches to head.S code (which doesn't save the link register).
>
> Thanks for your discussions.
>
> Are you OK with this current patch?
For me the current patch is just OK.


Huacai

> Or should I update this patch to remove the changes of arm64 and riscv?
> Or any other suggestions?
>
> Thanks,
> Tiezhu
>
>

