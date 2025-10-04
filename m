Return-Path: <linux-kernel+bounces-842088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E675BB8EC4
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 16:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90E2E4E8E7C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354B21FF55;
	Sat,  4 Oct 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgUGJyU9"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD620E704
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588118; cv=none; b=o6LHfjrY6rsgrMsrx1NXfomNOCiM2Ij2w8K5QeqGQ0NjVVGHIWsMEauc6L08ARS6PbYOOdTqKPNKeq1w3Z/XE0IKf+qNZLp46O3OK5KBYhiCq/2raJKzLgs1zGwWec8AcR/Tsp7C/JnZr8cR+Bu4JHtDWqXqyphRAhl/ZV6ZjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588118; c=relaxed/simple;
	bh=ojfKhhX/8wUyfMb+0xl3q5bck6Je10S6jxPo6lslJEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktkiOXcmWCG3I4wSfeDq7BifJJGA3Pl2IJrfIv1HzcmWgVsoHIk3BaYZN68rMivfs3N+FJRVLo86w3sSH251mSswkmYzh9UrrcmuXf3ExJ992FtKyOOMA7xtMIbzwzL5LICRBv8ZA+7BC+rSKeQbS+f8D80fUg79oLYvcsF2YqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgUGJyU9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso26650245e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759588116; x=1760192916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK0v4OX8W8IlBqQJ3Wzl4GiNbbL02OCOeiXzShfxTf4=;
        b=HgUGJyU9lY9XfMmR5jKWeDUi6m6Zz7B8cOMokwD14swueHss1J3cQZNw/fTghgopFf
         pNxCKAn5MK6a5x5sWvxwHG4yGeOxNoO7IBR7PThtpXXPHQRl63H9HS2kd9egqr4JD4ix
         wjHQtKTfRf8lwNFdlrD1w2AmqnntF92gs26RXr1r8YDvrthCMUJapVc6hsRl4pH5mBhi
         Mz1CCjxovOK3WncCW0SXUq+dsrrF7debagSsE2fL6c3RyGG6abNeGVxTD9OwAHHZOJDV
         p10Ir8KMYAN12HV29Wu3pv4qevyU5fA1+XItfJver/MbWsHiRjHVcYGGsBqEJZD8KxdK
         pgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588116; x=1760192916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK0v4OX8W8IlBqQJ3Wzl4GiNbbL02OCOeiXzShfxTf4=;
        b=IRBvgRscNSbkTPk/xcyUJHf015ujQp1Dl3iKrI11y6IhtJ8uDyTO37H7AxJMfz0OfR
         fMz3NwHzYobI1vIRQbJD9u+dXCdDar/3rw3kWGk6Fw1WlsvNLr4DugR7/HMqLOndY9/b
         4xFTtpmHZcMY1d659k0uf9FFWXk83HSMV4y9Al3U4P/2LxoBQJK0w04xvlt3WO4bXYdJ
         epyEHakPndTmXg/BlwWda2Fy6ipFtuGttmDxLFsl3PxaW8K2sV07+64VbJj1i2/Yx+VB
         h4kWZpMuV++6fXZNPH6mvOeCrAG7nl38jNgeFrKUqGVEw+aDKLi4y5NRUHQ3DnwZ2M5a
         jf3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWojn/bCh38XfkrO9oUKtX/cowMz/xDr3u0EodD2ui9NstDejJS63c7WnT1Go8uZfPzkrdba5nCurBg+PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZZbtjQEX+lbfbyPUHGL90zf8Pivfd7AXcrDC6vd/HPCeCI3v
	eKdAcf7EN2yYwN3oZ6U27VFpy1Qf/dUmWjJMOwa2V2XzG5UJbyJj22Uk1tYVMBGaQtz8CnaPuX4
	I7OP6mZ5+yA+ZsusM9g/Bl4YiRMrZFx0=
X-Gm-Gg: ASbGncvd0hyCgroA4pxv/dB+MBOuSj7ZTjjnYGq+GZXOfOTZI6j0QV2ltUNadErKg/M
	ONsewN+WCKZQJP0jgCIDVQHaZMcuLAcLl7Ll1tvcW3oV4UdewouA6A2abgJZrqZ1HIIfcEcmDV1
	u0R6SlUUGe5aQwrPjT3K6QkPlf9CsQABzpXWwjS2BHBk15X2BmMI5MAR7Wod+/WX0RpbUMsqBSL
	3d3KVeJS8fxQnpGtX8igunqW3AQq0HnTuUJjg0UsrlFBJpED43eZ2m6KpEQ
X-Google-Smtp-Source: AGHT+IE4Og6jwiPBBmHNkCPbBDPgBPqP5LwHuX1iUxTwECiL+8Mx2MUFp14C8Hb8qOdMhIteAMZP/szUC0EtCxKPQzg=
X-Received: by 2002:a05:6000:2dc3:b0:425:58d0:483b with SMTP id
 ffacd0b85a97d-425671ab837mr4385671f8f.45.1759588115404; Sat, 04 Oct 2025
 07:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1759584052.git.rongtao@cestc.cn> <tencent_8AF4D15B4475031E2185ACDE4B1495995707@qq.com>
In-Reply-To: <tencent_8AF4D15B4475031E2185ACDE4B1495995707@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 4 Oct 2025 07:28:24 -0700
X-Gm-Features: AS18NWCncY86K82MEOsvI4_LR56kfq3c6aMGWJWk4LCNmAzvAbhcCXDAaeximk8
Message-ID: <CAADnVQ+iERbZZ35CbPRamMqEu32ptEAXL0OQAhansfzBX+HDKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strcasestr,bpf_strncasestr kfuncs
To: Rong Tao <rtoax@foxmail.com>
Cc: Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Rong Tao <rongtao@cestc.cn>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 6:37=E2=80=AFAM Rong Tao <rtoax@foxmail.com> wrote:
>
> -__bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, si=
ze_t len)
> +__bpf_kfunc int __bpf_strnstr(const char *s1, const char *s2, size_t len=
,
> +                                                         bool ignore_cas=
e)
>  {

Still __bpf_kfunc ?

pw-bot: cr

