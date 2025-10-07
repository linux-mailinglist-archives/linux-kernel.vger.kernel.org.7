Return-Path: <linux-kernel+bounces-843619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E35BBFD9D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 02:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A4EA4E4BE7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 00:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4C51C84B2;
	Tue,  7 Oct 2025 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWNQ7Yzb"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96434BA50
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759796978; cv=none; b=D/UgbX2zpYuz8otIcCA79w7FS+4KxMFCOH8rSKlLDYxGch6sJx/rhEdv/ubjzG4+L4VZWmCvCN5MyMofpjqHElDW0AyCj+yE7NXxbPUU4yMO4nGnfsmkKTNZDKeAmpZ+KBiQYcexhTmyBQaxG4Inrs3yNgHFucAD5cSx4zqwsK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759796978; c=relaxed/simple;
	bh=VhE3lEq1z32eklFQuWsYnAJ9lZnTGtD7Yhza8TRvObM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxAb3en5wCxlgOGw4qNfdVsijTdt7fvVtR8lqm1ZhLlQHI/vkxtV/7z/cR+MkvKvtwKKDbCQvqBMeodYn1i9EoKDJR7RDpcRboizWsTT2gvXhTpW0i96Kdtm2dpxjh80d0uyXRRSIpMDmeKfpWRmM/k1y/aaeSp0R2rjrrGIGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWNQ7Yzb; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4914718a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 17:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759796976; x=1760401776; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P1hcAc7s4XhYQRH+R2s8ZmE/7qgDIwbOMHGuS8cxmck=;
        b=FWNQ7YzbPGGVtDv8QM3eamo20TyaTXxDNzZAA/9wLALc51sDgYd5+vZw8Z/cN+J/0L
         WzzjlJovjDRnsHCIBzzYwslNodV/GbKCzNZoC4ci5+3cKdIckLISeO/0+VKraWxMoCYu
         ExeWMWIySW5A0Bh1UN2cEWnVEdwoiGnsvAfWrk2l2PfVXMe4Hk/u+5B3bHsYSg8exAoL
         mvIanMj/R8f9uqpVfooHp18ROTgI9LzvKDcQ8LpPF9J0R9MVxb/3uhxZDvB7mHq7i/ce
         JDx+IcCTiNFtGqwCAMYoZieCywpKELLyMyhG5X54dcyVKQmRS15fiTA2ngWSoie1XTKB
         kpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759796976; x=1760401776;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1hcAc7s4XhYQRH+R2s8ZmE/7qgDIwbOMHGuS8cxmck=;
        b=SH4tFBMiRvgeGTtrHuxZZ3YluLMWYP0wsSQr11zyZgmN4pRHi5r9v/92UFjmzdSQ6+
         lY56rmkp6X6tq+CDQweQFnJ3GRlTxJs+WfMR/Du41dLhZ0GZutR2xIFS4x2bIFmk3Gwc
         nf6Nm5SG00zQZExpoh3/bFwcFGvJhI6Bks82cx7Vt3D1RK77C54vcRBePvXRUtNsw8yN
         avZ1Ys4kv73qXk1gnNUNnZ9iw+KItfZBw1xZhBYgpuFcsXEa65fs5Rxy2q2XcYpmm+rj
         JrywAiUqc699Bkpm/2WW4stE/ZebA4AGD8YcQpxHK4IHZUVp4SH+uDo3fLg5dcP0h6r4
         gv/A==
X-Forwarded-Encrypted: i=1; AJvYcCWxzZq3hV6YyJ5NFEwE0OWTFoTt5RWJo+Y7/f2JZNujnloQpzofcI9QmzmIJbtpSK6CShKu2Herd/dXntk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR5Y89NTRxpsFbXUHDT8cVCN4SmNc5TQmpWMEbZ4snx3nK1j9a
	loeQ6lBOrEWrSl3WfnbK4f6He8buOYoiY42sFP8YGWnEEzhXQql/EMTD
X-Gm-Gg: ASbGncs+Loq1im23MrwranTicOqJUH1WxLXRZ3NJSBTXLTO5TZGfF3GFUKj7txGK4RC
	QNGzRd202xuQTicFHoGxNX9tNhBKh29V1KgBaTW58pa6/u6RmFVDeJiWiZvzMhoBXMBmdG2PcNa
	WEHkGUNXsakJlLNvfYsyCBS4CiiFRLsdEqlQelEPn/6uX6nj13Y+3zYsuXnrssREwwZN6syAaBD
	pN9eXDrxqbkhpGA8GK3p81n7lyoKiuAJCIYco3F1ybGDVWnFqpAQaaBgd6gwjmJ/5a7PxXziX2d
	1KX47l/hanCEW5V2R3WD/O4ZqD3sLs0fcw+rZL2yUVqPz8Cx/7Q0WSRQ7K9aqbbPr0Fx6SAz+Dy
	OLcHC7v7CVYYXD/um/2SYyDiSoo8d4Et4ql/D8ar98nAcEvquI5FAziAMPcHtPRf41ljUFNhp
X-Google-Smtp-Source: AGHT+IEHDV8lJwxzCwsyHrfSYwJV2pBhYeFFmns7zfDlhAwW+nJPp4T/QHVKbEtSEmo+3rnHX8uZ2g==
X-Received: by 2002:a17:903:3c66:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-28e9a5ec80bmr168213335ad.19.1759796976151;
        Mon, 06 Oct 2025 17:29:36 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:d60a:adc8:135e:572b? ([2620:10d:c090:500::5:b20b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b87e7sm146377475ad.82.2025.10.06.17.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 17:29:35 -0700 (PDT)
Message-ID: <405da03e33853622da3a70ad88df3396c85926e4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test
 bpf_strcasestr,bpf_strncasestr kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Rong Tao <rtoax@foxmail.com>, vmalik@redhat.com, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>,  "open list:BPF [GENERAL] (Safe Dynamic Programs and
 Tools)"	 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK"	 <linux-kselftest@vger.kernel.org>
Date: Mon, 06 Oct 2025 17:29:33 -0700
In-Reply-To: <tencent_FC91DA604BE83F2BE3524865EA956DB41A05@qq.com>
References: <cover.1759588929.git.rongtao@cestc.cn>
	 <tencent_FC91DA604BE83F2BE3524865EA956DB41A05@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-04 at 22:47 +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>=20
> Add tests for new kfuncs bpf_strcasestr() and bpf_strncasestr().
>=20
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/=
tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index 2e3498e37b9c..d21330b4cc3b 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> @@ -33,8 +33,12 @@ __test(11) int test_strnlen(void *ctx) { return bpf_st=
rnlen(str, 12); }
>  __test(5) int test_strspn(void *ctx) { return bpf_strspn(str, "ehlo"); }
>  __test(2) int test_strcspn(void *ctx) { return bpf_strcspn(str, "lo"); }
>  __test(6) int test_strstr_found(void *ctx) { return bpf_strstr(str, "wor=
ld"); }
> +__test(6) int test_strcasestr_found1(void *ctx) { return bpf_strcasestr(=
str, "world"); }
> +__test(6) int test_strcasestr_found2(void *ctx) { return bpf_strcasestr(=
str, "WORLD"); }

Nit: I'd compress these two tests into one:
     __test(6) int test_strcasestr_found1(void *ctx) { return bpf_strcasest=
r(str, "woRLD"); }
     (and did the same for (str, "hello") variants below).

>  __test(-ENOENT) int test_strstr_notfound(void *ctx) { return bpf_strstr(=
str, "hi"); }
> +__test(-ENOENT) int test_strcasestr_notfound(void *ctx) { return bpf_str=
casestr(str, "hi"); }
>  __test(0) int test_strstr_empty(void *ctx) { return bpf_strstr(str, "");=
 }
> +__test(0) int test_strcasestr_empty(void *ctx) { return bpf_strcasestr(s=
tr, ""); }
>  __test(0) int test_strnstr_found1(void *ctx) { return bpf_strnstr("", ""=
, 0); }
>  __test(0) int test_strnstr_found2(void *ctx) { return bpf_strnstr(str, "=
hello", 5); }
>  __test(0) int test_strnstr_found3(void *ctx) { return bpf_strnstr(str, "=
hello", 6); }
> @@ -42,5 +46,14 @@ __test(-ENOENT) int test_strnstr_notfound1(void *ctx) =
{ return bpf_strnstr(str,
>  __test(-ENOENT) int test_strnstr_notfound2(void *ctx) { return bpf_strns=
tr(str, "hello", 4); }
>  __test(-ENOENT) int test_strnstr_notfound3(void *ctx) { return bpf_strns=
tr("", "a", 0); }
>  __test(0) int test_strnstr_empty(void *ctx) { return bpf_strnstr(str, ""=
, 1); }
> +__test(0) int test_strncasestr_found1(void *ctx) { return bpf_strncasest=
r("", "", 0); }
> +__test(0) int test_strncasestr_found2(void *ctx) { return bpf_strncasest=
r(str, "hello", 5); }
> +__test(0) int test_strncasestr_found3(void *ctx) { return bpf_strncasest=
r(str, "hello", 6); }
> +__test(0) int test_strncasestr_found4(void *ctx) { return bpf_strncasest=
r(str, "HELLO", 5); }
> +__test(0) int test_strncasestr_found5(void *ctx) { return bpf_strncasest=
r(str, "HELLO", 6); }
> +__test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_s=
trncasestr(str, "hi", 10); }
> +__test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_s=
trncasestr(str, "hello", 4); }
> +__test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_s=
trncasestr("", "a", 0); }
> +__test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr=
(str, "", 1); }
> =20
>  char _license[] SEC("license") =3D "GPL";

