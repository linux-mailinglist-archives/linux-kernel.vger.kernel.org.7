Return-Path: <linux-kernel+bounces-746568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7ECB12865
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2619B1C270F4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7BD15E8B;
	Sat, 26 Jul 2025 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGzzmP4z"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34B021348
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753492667; cv=none; b=ttIbtNwNyfc7ZxFB+y/s09EhEr3ruLYn4uCVs27jlMZWuCf2nUu21pNdC7QDZLCCK2fwEC97EyNmait87F5uq9ofq4YdwWW2X5xMeH+TKaQ+wmM69D1DAneW5oCgbgik6jwW4lzSPWFu+0mPJgqkAO8B7RBA1ZSAmKrFmh4MD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753492667; c=relaxed/simple;
	bh=rBuXP11cTTAHJUew+WFT5v30X/Kyh5kYLAanwOrwuHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBt2cYghQiIzw3PQxysOMBhHIKuLTsLKSEe+ZmpjoF1+eu1J6PLk3YX7zFc+LU4Zy3Bwe6kjYuWOQVEBIPW3RnamXBYVhqaLxgzYFvTghGtcV6HMNSh3ECkFmmEzFWeMmLKVda1PYdu5AhxlktP4E2rjLJsgJU6lU96ZS+iNvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGzzmP4z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235e389599fso81535ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753492665; x=1754097465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CzE9BhxSNhTzmTStidUkVVAUXhRg6U5w11hY/7VMWA=;
        b=ZGzzmP4z+ozzOD6iZlJhDd9XTPcVj9mfIxs13Y3LuoiBX7ZNwlTPJKuV7Gt0jcuakK
         NQ9/WpWwNLtFJeX/zjzX3+wt8h+F2DWIF2QZN3HS3mxHoYSWraGW5JyMu5Z7n5jdnowS
         RVlwYB/QDwUMhKoeY49+pFxe3qSc5n2+KxXOZz/tADLLynu/d1VEN45nWePqUbDDrmWw
         9ZEliS5aS2AoR/S8EWUBmWpqrfOxm2N77d4YgfOBnBXmbDX3Q8B8rHxUlo4NqKdt2O47
         PcmkO++cm7exZMqDXvBaLBAHrcTtk7Io3WpSIcaz/IMT7xaspLR8gT+B+Y7kk06UWBxI
         Cw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753492665; x=1754097465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CzE9BhxSNhTzmTStidUkVVAUXhRg6U5w11hY/7VMWA=;
        b=gRQ0muRRyJzez5I6ys5+lvP9qsndzP9b25cMvbWWFB30z5rpTVGM7nEM3FruGn8LTm
         v9FATadahZVOSWacsez38Nd/evch3TwADUZ3BBuC1QpooRd8AOvtsSzDFySGzn3CQd7r
         l+YVKMtoZv8cJa5BhoT5sMaSwz2BM0cOYGulIt8LJGTtO0Png4JNLmpugR2+FhhhfRHU
         lf5509jEymdRKvhBZtocBeow3nZ/DPPb91L53f+4Dc8bql/obLDiK1SB0INKjLkmFrLb
         FAxPGk9wHbc7jDZn5lwNvBpitydHjYrJL5eVkkOhBf8iRV9mfSn0EG4D6QlVqwsM5RhS
         uiJg==
X-Forwarded-Encrypted: i=1; AJvYcCU8sjwg2Ars5DS5Kc0d6VRSvEsppmqBuPFk3I7+GRsIzpOJMP6EghTq5E7bnoNmcVAbabuOasvjRASLfU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQRGBJVg+NcrmSIahcNfIykXcgGzcsaL4VWHbVXkLmML1LZKW
	Mw1rujoIkSzswzJkFNwQ9gxBJpLqnXUi7k7I7VnJhB1HS2zIC/TwOgOZ9w2Fc5cuWXlpiAZDUXU
	k6LsLGWPmKc4KX2R+DzDpGBs/StFWYCwBed11plPF
X-Gm-Gg: ASbGncvyPRTGrJQytJMQehPikiCsMhMH9v/bGfy/yRcGpojBb/aZrjzt4+TRgUDDdw0
	vsXRHUjVpF1fGwPU0Ue+AGF+FPmdYGPgWzHiCBYw2deiQ9GD4IUIlZeb0mUZ/8kR2DyMNIYK9PT
	/otgewDE32gU80/m8cICdHb4TMWA2QrSfnWctxAEQEcatg3TncynVqefpxjsUTpeyEusctwp2aZ
	xi+mCIg
X-Google-Smtp-Source: AGHT+IGlsvsTsUZQ2soytq96SMI1FjDFWMD3awMjXBXgJZ1qaV2XSIzI6poM9NTHhx1kuOS1iZEJCQ4x8irgTIVL9hE=
X-Received: by 2002:a17:903:2443:b0:22e:4509:cb86 with SMTP id
 d9443c01a7336-23fc5985aa4mr558365ad.19.1753492664646; Fri, 25 Jul 2025
 18:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com> <20250725202809.1230085-4-zecheng@google.com>
In-Reply-To: <20250725202809.1230085-4-zecheng@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 18:17:33 -0700
X-Gm-Features: Ac12FXyB6Dqt3xAkPNOvfvYZcxPt6h8cYTX5xTZF2VEnqGxHIqMsMCp8hmgsGbk
Message-ID: <CAP-5=fWbKj6fjxTccpszgMoVCc17e+2ZmixU5B3W0WU5wo_zDg@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] perf dwarf-aux: Better type matching for stack variables
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 1:28=E2=80=AFPM Zecheng Li <zecheng@google.com> wro=
te:
>
> Utilizes the previous is_breg_access_indirect function to determine if
> the stack location stores the variable itself or the struct it points
> to.
>
> If the DWARF expression shows DW_OP_stack_value without DW_OP_deref, it
> indicates the variable value is the reg + offset itself, and the stack
> location it points to is the dereferenced type.
>
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/dwarf-aux.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 814c96ea509f..4039dbd2b8c0 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1635,6 +1635,14 @@ static int __die_collect_vars_cb(Dwarf_Die *die_me=
m, void *arg)
>         if (die_get_real_type(die_mem, &type_die) =3D=3D NULL)
>                 return DIE_FIND_CB_SIBLING;
>
> +       if ((ops->atom =3D=3D DW_OP_fbreg || ops->atom =3D=3D DW_OP_breg7=
) &&

A comment saying the significance of DW_OP_fbreg and DW_OP_breg7 would
be useful, for example, why not DW_OP_breg6? Isn't breg7 going to be
x86 specific?

Thanks,
Ian


> +           dwarf_tag(&type_die) =3D=3D DW_TAG_pointer_type &&
> +           is_breg_access_indirect(ops, nops)) {
> +               /* Get the target type of the pointer */
> +               if (die_get_real_type(&type_die, &type_die) =3D=3D NULL)
> +                       return DIE_FIND_CB_SIBLING;
> +       }
> +
>         vt =3D malloc(sizeof(*vt));
>         if (vt =3D=3D NULL)
>                 return DIE_FIND_CB_END;
> --
> 2.50.1.470.g6ba607880d-goog
>

