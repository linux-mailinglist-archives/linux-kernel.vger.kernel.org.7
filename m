Return-Path: <linux-kernel+bounces-843587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C69BBFC7A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D33C4F2AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B81720CCE4;
	Mon,  6 Oct 2025 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioZKs4g6"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533901DE3C7
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759793030; cv=none; b=pnaprQBoeIEeYylTd+1WQygEI1QzG2mconVrf6ikJGnZOJ9aE1BUuUgJJAuC5Y31boSEg/urEkufA/EHLvTHSBIvv8SeI1w3ekcrKduKTNTMzaTmij5/bHmAO8LknFX3PUPjvdgsVJ62sR5botdqMKRKVH92V16rLRKJYlPzOjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759793030; c=relaxed/simple;
	bh=d2OYQ2kzK56wUw4T1jD15AViRIVAbD2XReef64GANLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqVDtUa7zLQNUU1K7LYrOAszimA1GI2/julAPfiuFNHFLpxgtAAXWlKW9+OqDdGNUbxoy4PTkKOkF5X3wX1ePDAR0TB+VfKteFHso81/w/oZFAY13xrvfPtUqUE9cK4zvWrBhC4EtepD38SCunGQ/PqaGobcn9hWLI18Y+nTIvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioZKs4g6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-78af9ebe337so3670626b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759793028; x=1760397828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYIvHYn3xKLZPBXfil04Zwpa8JQWMH7sChKAKdpX3Bg=;
        b=ioZKs4g6tB/xPUxLpKwS03aoKc0e9iqwX0aDaFh9EF3TdLu2KNhOlYTR5+G3GOVZKm
         IZjI0iJQ6ps2s/1c/nYLA1WkIrPYtTjEsDfr/CBiaHD8E1DrAvPgKYUzAz2SMDLWhcZz
         UwMJqdcvLTsyio6Fubft459B458aPyx1R3buRnau5j07CKf2BJGpxsVUigKkEX1OGtjy
         vJDs6Kn5YgGO4Oq9R5Wf5CZ2G/xZjQx4cXPFWpjVwbFx8ysd3TOuR279CYonz0ICxOAc
         ggQSZMWvjtuqrpichRHvqhSbda2cTW40bxEfqUk6x3YoQ7dI5yqe4eaY2V8xVPZDbhE2
         T0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759793028; x=1760397828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYIvHYn3xKLZPBXfil04Zwpa8JQWMH7sChKAKdpX3Bg=;
        b=gd1L1LERcuKBdVupIATBHE7TI+y6ab5446pUPmuB42bbtb4ooNTKdMBqEyH3WIjNVn
         06IWQcrigRMeoa2DvspoOxOLB9Ao0gg/wKRmf6tj9JP+LYK1ow9UEVAY8+1q+t2WVY2Y
         kajoNZR9ShBEDoduPVETVlI0CFGWjw2G29o550ruMOE2w3uEvu5uxZRtZvD4OxkUJT+S
         hfNCh/ZyAO63JkxO+H1Q4BGgUbeCvsbv/zeb5g2fZWM01tfDDrlBpuhWxMDPOIa6Wf9h
         /YedEes15Nv6AdP5k1/B31kAr88cOlmKMtGNN9VGjDrFL45Bkpi6bUPaVZ5OHSTMqpbB
         LDPA==
X-Forwarded-Encrypted: i=1; AJvYcCX6CkA0UHKhyS09YwD+OMvHPQ3CyYjQA6vJYnkbfMHzXoBQW2cRRPxbgVgHg/C57Ce/YcHYF8RR6DzDzY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3JdZ0440TbdAtayk+U0ENAu57RgEOJbRZCKQKcyi0gnmBF3b
	rAYVxpmlPnrheD3JI16UrqfbOb4Zi3OpD9q9S+ESnI1DC5SZ+Pl1Y6a5Dg0D+mqT2NxRpDiRj30
	rx/zSgnsshpy+Lwq4iL6xrEtm7HZN4Iw=
X-Gm-Gg: ASbGncvOd1vFdvTsa5Bym1ikWN2rpa9ftE77oo3XYEofVHoBFxOedHZVkD+F/ZSKkjA
	+aOQHOUgFg05Ld4EIJslNaRBX0+sqHsNcHBxLbp4vuJ3hpcv4zYQUepdYumF809xGHvj01g8nz+
	V0xf97xI/lqKv7/gbZEIZNAVR393k14ZpHqeBKVv1ycOY54j67qApTy5qvsLXje5Fso2ESOqnnU
	TfKZsIva5NPp644yJI/UnNZVnwWhMv2Osqb6j0H+uVP+aQ=
X-Google-Smtp-Source: AGHT+IHzAQrKEUd+2Sgk1OwVrHmaeqO4zcp3R/oMY9l6SJ986mluUKePS94BzBsen318WduSmozJRm/0N2ea2K3CUzI=
X-Received: by 2002:a17:903:198b:b0:252:a80c:3cc5 with SMTP id
 d9443c01a7336-28e9a544799mr151189525ad.22.1759793028572; Mon, 06 Oct 2025
 16:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759588929.git.rongtao@cestc.cn> <tencent_6D228941AB904DD6E1E58C8ACDEBEC280C06@qq.com>
In-Reply-To: <tencent_6D228941AB904DD6E1E58C8ACDEBEC280C06@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 16:23:34 -0700
X-Gm-Features: AS18NWBRcB8d7GLXg1ZXK1KUMqVIn0UEudKDvAjqByOwAzf_3qsgsmljblUPu5g
Message-ID: <CAEf4BzaEjv1Nc6VK9sAW2y3cGvyKx9WUpOugWn6vZkFW-k7wCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
To: Rong Tao <rtoax@foxmail.com>
Cc: vmalik@redhat.com, ast@kernel.org, Rong Tao <rongtao@cestc.cn>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 7:52=E2=80=AFAM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> bpf_strcasestr() and bpf_strncasestr() functions perform same like
> bpf_strstr() and bpf_strnstr() except ignoring the case of the
> characters.
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/bpf/helpers.c | 96 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 75 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c9fab9a356df..4df902e5f208 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3675,34 +3675,20 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, c=
onst char *reject__ign)
>         return -EFAULT;
>  }
>
> -/**
> - * bpf_strnstr - Find the first substring in a length-limited string
> - * @s1__ign: The string to be searched
> - * @s2__ign: The string to search for
> - * @len: the maximum number of characters to search
> - *
> - * Return:
> - * * >=3D0      - Index of the first character of the first occurrence o=
f @s2__ign
> - *              within the first @len characters of @s1__ign
> - * * %-ENOENT - @s2__ign not found in the first @len characters of @s1__=
ign
> - * * %-EFAULT - Cannot read one of the strings
> - * * %-E2BIG  - One of the strings is too large
> - * * %-ERANGE - One of the strings is outside of kernel address space
> - */
> -__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, si=
ze_t len)
> +int __bpf_strnstr(const char *s1, const char *s2, size_t len, bool ignor=
e_case)

keep it static?

pw-bot: cr


[...]

