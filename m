Return-Path: <linux-kernel+bounces-887664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D0CC38D4A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D212D4EC711
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AA3238149;
	Thu,  6 Nov 2025 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NayA01pH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F1B1BBBE5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395256; cv=none; b=esjDwuYnm/2RfYJiaBvAgHPC2OBxWP809aP3eBt1y6iv9goUjyXPzZpXEoPgNOMJ/TYC3Pql62vMm4I9Hi9HM9GCabZfSO3BpEshSYf0pO4J8rsm0zabPILL7IBPv0mVDi5g7r6f1Y2Gg2TrpJD/v9NcGUV5AYg4z7+X1p+1nso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395256; c=relaxed/simple;
	bh=vZP6Olr5BkV89fHbnFl2sWgdkU0Nu6NEN5nDJ+HXmt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVJgkYNq1hWVM7a3+yOW2x3FacIU5caJW3WzeN18D0UU6gvlw+tRd/gOYLBxed8QYlqqLJ4dmkft1BPxYcUgZczgdaPt/4WjdVrX+7FhYK0SucylOWgsLjf2jJDlg5SYwoGquplGzCTqJoQdrA+/3JKQRig4W4MONlVX+cz2Mns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NayA01pH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso2517355e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762395253; x=1763000053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pID6uUnnVVZ9vUknZjr7R/tHvBIqPxx/hilxjQ4G/4I=;
        b=NayA01pH7J4QAApvV6oY6JB9WF6zyrc7iVR/2oNn9ntLYTClVYcxFDZqneiLVuoy6t
         pe3+Ws2RO7Tej5S8Ulx3RaMx8N2E2KO1odP4b5A929XWZNqrWbtix44axXqAIb6gPFkx
         GlpFkNg0KsxsITlLCUtmQPoy8skXOh0PnXpYK8pcmGsNckYAp/JhiRyYX6FGoV38FsRg
         3q4xJ+VkUxESZj26RO8rCVai7geBECTyJsEt0fF3jisSwvvWbqBI+RXyHSazb0EvuRix
         JYKuzNgjhJkkvxkSr1n4QZIxcPw9TpF0mnWfRZTtxwfGSoEfFm9V1ubNoe0iZN5CSk3J
         TpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762395253; x=1763000053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pID6uUnnVVZ9vUknZjr7R/tHvBIqPxx/hilxjQ4G/4I=;
        b=YmoIxpjCwHJpyhUOOgHnMyvrBZgnQ9YCP9BsoWdJrK2lXQNH5/NIAmyPu58w23+m4t
         kBP3QB3Qwv5YOHmuv28Ls3ZzTFsbmCIvkZBQ+mG2bYrwZFcCkKk51E15KOE0igphBoRB
         Hep55D91IesveXGHQk3wyt//xiXF7P8LHUj6v89d2gm9q2c4lRG6kNbs8rydU7vGgnZS
         33sca8CuzCVJ8OxtS8J78mEnH3o4QWZuN0k6HgODLbmzbly0W6T0o461spdgWEhlDD63
         56XaSfJ8ZnPGntyITfQQw4/Qm25IHq6shAZMQpyw20seC5vivcIBfSxd2uk28OrQ9B06
         qmgw==
X-Forwarded-Encrypted: i=1; AJvYcCVJLNAZFha291OC41owj5LkHnEm2Q2+0CPgAR07+Eb6aYMHSCIS4KTYwxUnn4UiogWiVVeJxrIUnvqtNbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy176iy9+H1tunQh99pjTDbXzHSL05A+YebXS6Q1f5wBmLc3bTj
	ZTXJv9XckMV8DN8vvuqQ00xv69VEfBr0vmUB4r4DE+xwNBBmCkuw8+kFvFVGIhrsSW4u2h1zxXH
	XGMWq9tZbsHA/GSCd5C4GvSg8Cd8COb8=
X-Gm-Gg: ASbGnctbPiam9CPZtv6liZPYKR/695DU/nTQqEOO1WzNLxjKOuHQzBieELufV6+q4Nk
	TdQuMbFB5HrlGh9u+OOn/k6mvz3si6VaxFKyHxj5e2CC6yt4XD2WpadLJuwYIWXDtPEgeCqoXuE
	GRxVigsABHxiW92+k4Y9/SmA05c0PV5EPiSDmejE1AxaSdzixMo0xxHu/QPmFNUk78mlWsA87ll
	F/6t79rlsRZm8CcrUkA2WQ/Wu5WAUzxY4SZL0s8bZYSYsB5Hmb9roZbE677SW5mqfTekWbxofAD
	cpSjPGjBq7kVP9BlIgyKNbeb35n5
X-Google-Smtp-Source: AGHT+IHNnfInoqONg+HdDsdA3ANtxnE3sVDgNmGAhLj4s+3clgxi2RV1/L4viLoDYukFGUUERUQj1xR+74oc6GYdLj4=
X-Received: by 2002:a05:600c:621b:b0:477:fad:acd9 with SMTP id
 5b1f17b1804b1-4775ce7dfcfmr67517835e9.34.1762395252988; Wed, 05 Nov 2025
 18:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com>
 <20251101193357.111186-2-harshit.m.mogalapalli@oracle.com>
 <CAADnVQLe6a8Kae892sVaND-2p1DQDXGD5gqxHWHHUC85ntLCqw@mail.gmail.com>
 <e9d43dab-cfae-48a8-9039-e050ea392797@kernel.org> <CAADnVQKzSBZYaj0iMkNBk6FvaOket1mWPksX661zwC2rg2FBkQ@mail.gmail.com>
 <7874cfab-3f96-4cfb-9e52-b9d8108bc536@kernel.org>
In-Reply-To: <7874cfab-3f96-4cfb-9e52-b9d8108bc536@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 18:14:02 -0800
X-Gm-Features: AWmQ_bkDFU4rnwNyySArAEKJqcvgmyxv0uWO4gd3WyExlNwj1KcULnAVkj1_8jg
Message-ID: <CAADnVQL7cLYPKEQOLWi1DjTZjhE_Fy4zWLrWG+=NSeN821SyMw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpftool: Print map ID upon creation and support
 JSON output
To: Quentin Monnet <qmo@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:05=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> 2025-11-05 17:29 UTC-0800 ~ Alexei Starovoitov
> <alexei.starovoitov@gmail.com>
> > On Wed, Nov 5, 2025 at 1:38=E2=80=AFAM Quentin Monnet <qmo@kernel.org> =
wrote:
> >>
> >> 2025-11-04 09:54 UTC-0800 ~ Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com>
> >>> On Sat, Nov 1, 2025 at 12:34=E2=80=AFPM Harshit Mogalapalli
> >>> <harshit.m.mogalapalli@oracle.com> wrote:
> >>>>
> >>>> It is useful to print map ID on successful creation.
> >>>>
> >>>> JSON case:
> >>>> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 valu=
e 8 entries 128 name map4
> >>>> {"id":12}
> >>>>
> >>>> Generic case:
> >>>> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value =
8 entries 128 name map5
> >>>> Map successfully created with ID: 15
> >>>>
> >>>> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
> >>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >>>> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> >>>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com=
>
> >>>> ---
> >>>> v2->v3: remove a line break("\n" ) in p_err statement. [Thanks Quent=
in]
> >>>> ---
> >>>>  tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
> >>>>  1 file changed, 17 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> >>>> index c9de44a45778..f32ae5476d76 100644
> >>>> --- a/tools/bpf/bpftool/map.c
> >>>> +++ b/tools/bpf/bpftool/map.c
> >>>> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
> >>>>         LIBBPF_OPTS(bpf_map_create_opts, attr);
> >>>>         enum bpf_map_type map_type =3D BPF_MAP_TYPE_UNSPEC;
> >>>>         __u32 key_size =3D 0, value_size =3D 0, max_entries =3D 0;
> >>>> +       struct bpf_map_info map_info =3D {};
> >>>> +       __u32 map_info_len =3D sizeof(map_info);
> >>>>         const char *map_name =3D NULL;
> >>>>         const char *pinfile;
> >>>>         int err =3D -1, fd;
> >>>> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
> >>>>         }
> >>>>
> >>>>         err =3D do_pin_fd(fd, pinfile);
> >>>> -       close(fd);
> >>>>         if (err)
> >>>> -               goto exit;
> >>>> +               goto close_fd;
> >>>>
> >>>> -       if (json_output)
> >>>> -               jsonw_null(json_wtr);
> >>>> +       err =3D bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len)=
;
> >>>> +       if (err) {
> >>>> +               p_err("Failed to fetch map info: %s", strerror(errno=
));
> >>>> +               goto close_fd;
> >>>> +       }
> >>>>
> >>>> +       if (json_output) {
> >>>> +               jsonw_start_object(json_wtr);
> >>>> +               jsonw_int_field(json_wtr, "id", map_info.id);
> >>>> +               jsonw_end_object(json_wtr);
> >>>> +       } else {
> >>>> +               printf("Map successfully created with ID: %u\n", map=
_info.id);
> >>>> +       }
> >>>
> >>> bpftool doesn't print it today and some scripts may depend on that.
> >>
> >>
> >> Hi Alexei, are you sure we can't add any input at all? I'm concerned
> >> that users won't ever find the IDs for created maps they might want to
> >> use, if they never see it in the plain output.
> >>
> >>
> >>> Let's drop this 'printf'. Json can do it unconditionally, since
> >>> json parsing scripts should filter things they care about.
> >>
> >> I'd say the risk is the same. Scripts should filter things, but in
> >> practise they might just as well be comparing to "null" today, given
> >> that we didn't have any other output for the command so far. Conversel=
y,
> >> what scripts should not do is rely on plain output, we've always
> >> recommended using bpftool's JSON for automation (or the exit code, in
> >> the case of map creation). So I'm not convinced it's justified to
> >> introduce a difference between plain and JSON in the current case.
> >
> > tbh the "map create" feature suppose to create and pin and if both
> > are successful then the map will be there and bpftool will
> > exit with success.
> > Now you're arguing that there could be a race with another
> > bpftool/something that pins a different map in the same location
> > and success of bpftool doesn't mean that exact that map is there.
> > Other tool could have unpinned/deleted map, pinned another one, etc.
> > Sure, such races are possible, but returning map id still
> > looks pointless. It doesn't solve any race.
> > So the whole 'lets print id' doesn't quite make sense to me.
>
> OK "solving races" is not accurate, but returning the ID gives a unique
> handle to work with the map, if a user runs a follow-up invocation to
> update entries using the ID they can be sure they're working with the
> same map - whatever happened with the bpffs. Or they can have the update
> fail if you really want that particular map but, for example, it's been
> recreated in the meantime. At the moment there's no way to uniquely
> identify the map we've created with bpftool, and that seems weird to me.

ID is not unique. If somebody rm -rf bpffs. That ID will not point anywhere=
.
Also it's 31-bit space and folks in the past demonstrated an attack
to recycle the same ID.
So the users cannot be sure what ID is this.

