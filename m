Return-Path: <linux-kernel+bounces-895993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0349C4F743
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3FA84EC612
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F239283682;
	Tue, 11 Nov 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emk1aIgn"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0D27BF93
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886156; cv=none; b=cRndnkYobpsa3xnnUO0GbOHNybS2OLUulT4gCmmn86hG93nLhFvXcCEVRToQCPZ2ylfZfrZzhLVnvL9RTSc5xhd2gBOCo8XrCAluWTuOVXvukMRFHWzxDf+n13YTajPp6kOQ98fk4TUoBI20KWmFu9vZ14TeGunFx81IeQHvDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886156; c=relaxed/simple;
	bh=oiW+96lMPGbksmm+8Ne/yv29cjNp/Y+B/l3wSqF5fv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciTCCwsDU4xcwPGRg5xlbUyASkCTeGy088NDvA2HtXWcFhAelsfXeGTxVe6Nb886c8wbfJprkmHBoppcEEPEfRKwi8pAET9M6L/1uDPrayHrPajRdN4aI6SbfIomx1sYP8evPCBd/C+hDisaOWyWDFxQP2HvlkH0uCCsErY2EGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Emk1aIgn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c7e438a8so3964342f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762886153; x=1763490953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R2qMufgLCOrAchjb40CxU794Xzs2ku3JcW+CtQ3zLU=;
        b=Emk1aIgnE+o+xS6ecQLTUWoJ8IDJh4A2k0EK8Ad5QVZOlU42wx61ZgRE0RQRu7LgmU
         tGRRydpHr6dv3nhePGC3P4pXpn+KMjd8VvCQyq+kbAgZ1ZbW+OVA4/g3f+2J3VNO1nEs
         tEVJiylo90npaCRuP13jOcBa8jDhvGp7DEBsOk5PlxZEdLoa1NnWr/Vyt7xNFndKQriY
         1afpT8+5mZQwBMXZptTQRBR91TEuTexjLK1WZ9JJMJX5H61LgJnjciVrpnPQ+LZY9YMq
         pBZYK8BfDyfgqtKdEUaGfZj39Vg6xUGSm/hYOUTZO4fEq8RZ4leUlNmCuwjOAiB4Guni
         OwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762886153; x=1763490953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7R2qMufgLCOrAchjb40CxU794Xzs2ku3JcW+CtQ3zLU=;
        b=ZkGqi6VINGdT8JYjDAsAhNDCn0c3ED5WKQAHAqvqcbGdQp1WuLbaQY3UGsInwZVf6B
         QGSG7x6hBXzDVMmifGDqXH/Qt68FL8rfkPDLBCTqimRg2cOIKH/tMG7NDOgN8mlDmUq8
         w9I6hcADLDZCTIWUOZwocJxfgf09iraTutxRqWkJ3oGh3XotT1CF2ClPq/01a86+qMbq
         rt3uucW+2iSBhkPgIhM6rUH40x3PmXT7oC+5Gy6yz6oAwm5ngIUF4v2SfK9WUprdL8ny
         dSfAPESO+zvZf2u9daVNJ6UusG35rrnZzhA2nJc+iyGVzy6LzVnk+i73unGdhTWCtszv
         CFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl9Af/6NaepHK+GTGaBo4LemMm4VsbkP6aoIk4e2GXLUDAXVHaUe1FyeNazl/SBAO/OFPbQqO7rtzTHJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVznc4mjGvLHV6LPRapFfrzpIvIl8LLhMB7gKGInwKllv8GoeQ
	ViQBIFF9x0geRXdToXCuL1BAoncZIfxWK2f6hNh87BrSl1OKpcIIurAF10cAx7K7IAQBbPmVSbK
	26jmUvRjangAOfQkAjQ9r+SOkFMK9JL+kTNVW
X-Gm-Gg: ASbGncslfPJ/UFin4FF5TX4b3tSwSh4h7P4vzeCJ4Tf46IA3XfS4cTvhh8huavZrVSr
	BOMCV2d43ynllB+HAibY4NdlTvvr0oBLE3szrcANQXXLLum83KgLHgVX4H/EKZNmefcnJHmeGpp
	lMm1vrl44cK5na5lQKfKYnSj9l7fAVxQA3y5RAoV6t+TGO9SjbOSpPFV+Y0UxFTr0nOTWWm5XdO
	Qn1UGLis51P71CK1YQwZT3Mr17K9vyqs/bKbxCmosXyI+bGslZrcfeRSOSWz5hulitLNoL/o1dR
	r1hWqQFHAJw=
X-Google-Smtp-Source: AGHT+IEGQ85XhZEhKH5h5Lfi8UP2rxKI9DL75Cd87eZEEXwX3fis/UXrcV0y9f0bDUJzlJhMrSLfyBqXOYYDoYp9AR8=
X-Received: by 2002:a05:6000:430e:b0:427:813:6a52 with SMTP id
 ffacd0b85a97d-42b4bdaeeeemr171423f8f.41.1762886153125; Tue, 11 Nov 2025
 10:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106052628.349117-1-skb99@linux.ibm.com> <CAADnVQL3njbb3ANFkDWYRC-EHqAqWSwYs4OSUeKiw4XOYa+UNQ@mail.gmail.com>
 <aRNJE5GRUxdlJbZB@linux.ibm.com>
In-Reply-To: <aRNJE5GRUxdlJbZB@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Nov 2025 10:35:39 -0800
X-Gm-Features: AWmQ_blGfD4ejxDR3wU_DBvkCzWL8lZb2tvYxWR8OAf4rdjOl-Xg9GCng8SORHQ
Message-ID: <CAADnVQLbMZdMO1zM2OhLsX+w22wQnNQWf60fazctCeEzPUfr0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix htab_update/reenter_update
 selftest failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, sachinpb@linux.ibm.com, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:33=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> On Thu, Nov 06, 2025 at 09:15:39AM -0800, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 9:26=E2=80=AFPM Saket Kumar Bhaskar <skb99@linux=
.ibm.com> wrote:
> > >
> > > Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection and re=
covery")
> > > the updated path on re-entrancy now reports deadlock via
> > > -EDEADLK instead of the previous -EBUSY.
> > >
> > > The selftest is updated to align with expected errno
> > > with the kernel=E2=80=99s current behavior.
> > >
> > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/htab_update.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/t=
ools/testing/selftests/bpf/prog_tests/htab_update.c
> > > index 2bc85f4814f4..98d52bb1446f 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > @@ -40,7 +40,7 @@ static void test_reenter_update(void)
> > >         if (!ASSERT_OK(err, "add element"))
> > >                 goto out;
> > >
> > > -       ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
> > > +       ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");
> >
> > Makes sense, but looks like the test was broken for quite some time.
> > It fails with
> >         /* lookup_elem_raw() may be inlined and find_kernel_btf_id()
> > will return -ESRCH */
> >         bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
> >         err =3D htab_update__load(skel);
> >         if (!ASSERT_TRUE(!err || err =3D=3D -ESRCH, "htab_update__load"=
) || err)
> >
> > before reaching deadlk check.
> > Pls make it more robust.
> > __pcpu_freelist_pop() might be better alternative then lookup_elem_raw(=
).
> >
> > pw-bot: cr
>
> Hi Alexei,
>
> I tried for __pcpu_freelist_pop, looks like it is not good candidate to
> attach fentry for, as it is non traceable:
>
> trace_kprobe: Could not probe notrace function __pcpu_freelist_pop
>
> I wasn't able to find any other function for this.

alloc_htab_elem() is not inlined for me.
bpf_obj_free_fields() would be another option.

