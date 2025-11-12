Return-Path: <linux-kernel+bounces-897591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C71C53672
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0C15011C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010731B11F;
	Wed, 12 Nov 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSECrgHG"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8A3148BA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962058; cv=none; b=K5h8xPyoBrcN/JDXWiYrdHUzcoq7wDzUiWFb1ZJ+USlmy8LT0HZW8GumONvvfpIPXNNb6LSBmdpnf7O+edlV7L/kMKggQamhFR2MA0noSQz6MCMki7pzzTWD5NscYRYel6aHaigJU5VJBMcWLs/2s4taCYcQqpMzvZeqq7dRY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962058; c=relaxed/simple;
	bh=UBRooRStreNcjVeeAT3XNznOyrQlM7eqhrh8UAVvTqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iH7zKlvlbf9zQn45VrhsUrZvWKcGVMd5hKYlyJQFUkRLDOrYVY1zfJqDTvxYpNfPe2YCX5gg8sPng4azI72Dqhlr+N4N5Pu3ihWA3w4mYNwzYgIgGEg32ng5gB0Pz2wsxen7RRsf1pmyZA91I0mq0z03GAd80xPr/x+xkt7Xdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSECrgHG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso811554f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762962054; x=1763566854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFs3kTHkGBrKQxp1G6sqUrQi97LKHlOLvTeMD+N2qro=;
        b=LSECrgHGZecwuVBvZSUywXc0XjvlUOgCT4KjyIQhE76u67oEPsLgs8ODP69vtz3vNL
         bz8UmzWozfooOaSlind5wmOeBZHE9Oj1aR94362XHDCWocGqh//iVvJQqVuU/eGULA57
         CACRa0rQfL/QoP8ewqapnkPU/x1MvW7I/ktSdKJIxQxubeuqunUJdMyB8/s+MSddv9SL
         0pxyWdvDl36Oob9efEKQ94Z3uvkFXBU/kNaorTATTkpWa74ycqOEHiE9llHCUP6F8320
         mig2CVLqp/FqY5YgAPM3Y5DYVT66QgfrkTmkumZyHgfJ6vsyReI8bwrCU4dy+BqXZxQq
         GbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962054; x=1763566854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GFs3kTHkGBrKQxp1G6sqUrQi97LKHlOLvTeMD+N2qro=;
        b=VGoxxR039V2hKh/cfKo3rwoz1Iq3cwzK2xp9rDNjq/dXpGr/nTDmLoBvwadXBGa3iI
         znYnk8KeUmQHsaABPm2QtCBceYtxbMLJRLEr8/Fm2tkdOG5sC6KvIouyTLxSNmqMMgSK
         oSIDkCEZ9EzohCiRIbS1baFrfP6WUI9fwE9/SW5aTWAhJTyjrKlXXpMg+XlkML9KvWLw
         RdFmFdj2JQ33bNFxZQ6fyxECW63cUbDLP4Ne2M5tP3aqZtWkU1AEwOn6peMntI7bjfEJ
         RrSr5O4tbUIbOyJRJ0oqYBoAtBSqjOFPwNa8ZQ6lYhtkck/44cSsV2841ruWgTpvmxIK
         EmOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl3gHjhx6UCG/PCcpoFq1AsXwtFAwXw6ZLq4ECyHoHXI6ZNtlzk7y01mBx6EOWmo3vkP9qfH7POAbEza8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGSaH77SgeXlGyf0tKW3LAe77WVRTx/lpZe2J+BSbWN7N2+1j
	vUmTsSjFszsUfszfR4oYN+pjGXAzQfXRu1UFEXyRBGCI1EkKkIcQy/GB8z57dJIQoOuDN1ASPaZ
	HklJWw/320fKPFmdgrUaEeZuzDP8QMww=
X-Gm-Gg: ASbGncsYa6+eBHJJUJksb3BE03fzvrNjud7x0CRoQ1oikaiyBEA6up9Svgay29GiqY8
	7+c3vytxrEjXMLbYVjlCHBdPv77nee2pk9ee/gbgDDvXu9y9XR2i91k5g3i+wSe9xJ37KUdNdAY
	JJwVpvVeRpQgdpSFpWXPLex1LTM4Rz1Afo18t4ByaSGOJwgaU+qpjmGc0w0Akh0mKP9DnDQJ69u
	rYBGh2UhjqYU+pCqCixah35eduZb4GWXIo05TVezJo8QnN2WX7TmRu2ZVCBih1N9YUDPIIixZga
	y57HM4wCwbDI/NBM
X-Google-Smtp-Source: AGHT+IF2MdyR6XNYV6P0kSXew9d429BiXIlJ/9qjxM1PCZKvgnbjMGzwbb2Yef3RI8X+Baihq5Fm7yML2MkKdKxj48k=
X-Received: by 2002:a05:6000:2601:b0:429:b751:7935 with SMTP id
 ffacd0b85a97d-42b4bdd6073mr3183964f8f.56.1762962054363; Wed, 12 Nov 2025
 07:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106052628.349117-1-skb99@linux.ibm.com> <CAADnVQL3njbb3ANFkDWYRC-EHqAqWSwYs4OSUeKiw4XOYa+UNQ@mail.gmail.com>
 <aRNJE5GRUxdlJbZB@linux.ibm.com> <CAADnVQLbMZdMO1zM2OhLsX+w22wQnNQWf60fazctCeEzPUfr0g@mail.gmail.com>
 <aRSi7MADBZBoLLEP@linux.ibm.com>
In-Reply-To: <aRSi7MADBZBoLLEP@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Nov 2025 07:40:43 -0800
X-Gm-Features: AWmQ_bn6DUma_HA2eb4GQSnH2fwI_ZpDCfXLcjZKYxzENKsIfWopPWj3TdOG48A
Message-ID: <CAADnVQL=zjYyVpFSDxGJ4dF5kW+cg+1c+AA1rX3WqxNRMfT4cg@mail.gmail.com>
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

On Wed, Nov 12, 2025 at 7:08=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> On Tue, Nov 11, 2025 at 10:35:39AM -0800, Alexei Starovoitov wrote:
> > On Tue, Nov 11, 2025 at 6:33=E2=80=AFAM Saket Kumar Bhaskar <skb99@linu=
x.ibm.com> wrote:
> > >
> > > On Thu, Nov 06, 2025 at 09:15:39AM -0800, Alexei Starovoitov wrote:
> > > > On Wed, Nov 5, 2025 at 9:26=E2=80=AFPM Saket Kumar Bhaskar <skb99@l=
inux.ibm.com> wrote:
> > > > >
> > > > > Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection an=
d recovery")
> > > > > the updated path on re-entrancy now reports deadlock via
> > > > > -EDEADLK instead of the previous -EBUSY.
> > > > >
> > > > > The selftest is updated to align with expected errno
> > > > > with the kernel=E2=80=99s current behavior.
> > > > >
> > > > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > > > ---
> > > > >  tools/testing/selftests/bpf/prog_tests/htab_update.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c=
 b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > > > index 2bc85f4814f4..98d52bb1446f 100644
> > > > > --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > > > @@ -40,7 +40,7 @@ static void test_reenter_update(void)
> > > > >         if (!ASSERT_OK(err, "add element"))
> > > > >                 goto out;
> > > > >
> > > > > -       ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy")=
;
> > > > > +       ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy=
");
> > > >
> > > > Makes sense, but looks like the test was broken for quite some time=
.
> > > > It fails with
> > > >         /* lookup_elem_raw() may be inlined and find_kernel_btf_id(=
)
> > > > will return -ESRCH */
> > > >         bpf_program__set_autoload(skel->progs.lookup_elem_raw, true=
);
> > > >         err =3D htab_update__load(skel);
> > > >         if (!ASSERT_TRUE(!err || err =3D=3D -ESRCH, "htab_update__l=
oad") || err)
> > > >
> > > > before reaching deadlk check.
> > > > Pls make it more robust.
> > > > __pcpu_freelist_pop() might be better alternative then lookup_elem_=
raw().
> > > >
> > > > pw-bot: cr
> > >
> > > Hi Alexei,
> > >
> > > I tried for __pcpu_freelist_pop, looks like it is not good candidate =
to
> > > attach fentry for, as it is non traceable:
> > >
> > > trace_kprobe: Could not probe notrace function __pcpu_freelist_pop
> > >
> > > I wasn't able to find any other function for this.
> >
> > alloc_htab_elem() is not inlined for me.
> > bpf_obj_free_fields() would be another option.
> Since alloc_htab_elem() is a static function, wouldn=E2=80=99t its
> inlining behavior be compiler-dependent?

of course. Just like lookup_elem_raw(), but alloc is much bigger
and less likely to be inlined.

> static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key=
,
>                                          void *value, u32 key_size, u32 h=
ash,
>                                          bool percpu, bool onallcpus,
>                                          struct htab_elem *old_elem)
>
> When the fentry program is instead attached to bpf_obj_free_fields(),
> the bpf_map_update_elem() call returns 0 rather than -EDEADLK,
> because bpf_obj_free_fields() is not invoked in the bpf_map_update_elem()
> re-entrancy path:

Then make it so. Think what you need to do to make
check_and_free_fields() call it.

