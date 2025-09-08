Return-Path: <linux-kernel+bounces-806842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A8B49C5F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043273B72ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C592C2E2280;
	Mon,  8 Sep 2025 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g86+W2cc"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06802E11CB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368269; cv=none; b=ESGGw/5LlhT0OvqVLCxOnldB3JJKAPkVzYlvq34HMkxvpfoJL+s+ISOQibymfXldhkYp82CmrPiqbEiLA0DT8O1I3FbLMw5WjMltSR0vg7zE5zERg1q6RwPQ4Da0ZdJXHf72uugTpRNOmo+O7qEMhz/XnZ+f9SeyKc+WWxlDsYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368269; c=relaxed/simple;
	bh=VN1/pnuUZie25pZLbsZz/JJS+mATsTYyYjRzSW9ONYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn0oIKYO4x3qToa6H5dzWMbLEWromfpfi5F6OXbL0f1TA5B5EPe8HIhoNsJ0H5ztCeqXbmQ3X2F6XGX9JNrE6eX0/sjMH93vynvYSY3fChH32qQFWxkR3s9PSqkMHWjXNe2zvOiMmEw2rarmOvIopvaSC7Fe08snaJxRuKOBpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g86+W2cc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24cca557085so446625ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757368267; x=1757973067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptukJrDpMQC6yvQq7fy8/E7wgh/xTIuczpHu3sAzFmo=;
        b=g86+W2cckNyji8bEgT3/RZuVkV8MQ6hIsRpnFgIfI04LvZRf5cVy8MzHyX1oBv59/R
         ZymLgNTMkEBtFsWtxsl4bMlLq7n+Em/GOeGfCAX8UXCtu+eFeInZK4OzYJ7Y0RLWM3lb
         2PZy98CFW6da0kBcZpPcqxpXu1Wu36v20MsTSRqyaF7fOLuvcYrvDUeguhrJ0b0OaGy/
         6HRI2OJ0Kv8elLXpjedhL6svpoi0rXpnUZOu3QtW83DYUozkdfSkmAEMNng5ZvHy2IsN
         jG7QQA1LQMbmfNV+IVtq3VrDopRZSKYRpP+tadDMFlRa+tf33AfmNQcq1vMKjk1W3DVq
         hUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757368267; x=1757973067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptukJrDpMQC6yvQq7fy8/E7wgh/xTIuczpHu3sAzFmo=;
        b=CVAWjXe0dT62SMDc6gUKkie67BjlxnL2NavH1c6DcuuWe9jyQOv30yT17Ro6Lnp+9D
         QjQoanemxbMohy8MfCSrSNusLiq6ErTXHJpqo8/Vcuu7NMnYboBi1eihqJhmvfowPJju
         tjXlZ4P01e6ub2D8Re8AzLD+YGMCWXGSt2nCTCEySkbkj9vwGi1bXOdKwbK8RrxjkHJg
         +xA6kpBKBER+1zor7XLvgB8VdmMDAecnrnkGHrPE+tY/55IjRIWjKFUcc4eC0ckPNsjw
         fzh1JQo5DtqXO0F89ZLhxJn/gFyx5SYY8WjzMSst036GdgFlFsReIymBHryYoF/tYhlz
         JNaA==
X-Forwarded-Encrypted: i=1; AJvYcCUKPBgtWfJ3v3s3YDtb7HTAk3UnzVMi6iyri69iLXPRc7+Zg7TKXV1nn7H/Psh9g42nvKN1fwArS3f4Xyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UgaIP0GX8EqrTL6bR/7taRLnKAHiZ0CLOIE6I6KqwWRmrzyA
	jbi6CAzckpA8RZ07QZebc/uSCwfSXenDyDRxkC2WyBdrqtrjEEK+pzOMjQt3IItG7cKp4NSVSfH
	6WFDlmswXfPgP2lgp3ik7VyDWnch8Xt5KjulBUNH3
X-Gm-Gg: ASbGncsMiqmhFzl2o3ZXh7VaFSVwZGmX31r+vdDYM+up56EE0xAqndQLhIkdfCGCRRx
	byDrBwhwt4MgxU3aBwV2eoZT6Ly0p6GjE3s0y8Ho7VUrPonRGdH7t2oSNVIq5DXjdAnyAL5s/y1
	dZCzVwoRlRbnzxZ4peMEPS/uPzsfoN5F0VOH/Y5V6JAXBy+2lkmzRa0/CG1FgTXYWxlxedR5a5j
	J2XgQK+2ebJeA6IE6yHwEVwSGYoLmzTgPnZGQ==
X-Google-Smtp-Source: AGHT+IFXtljAmlRPmXSQo47bOh2JUAzRYbs2TGR7KxJxt04lr5eJ05ZEY/fT/oNdcobAsGgCJW2PUMmxfR77o9q35vQ=
X-Received: by 2002:a17:903:1a70:b0:248:aa0d:f826 with SMTP id
 d9443c01a7336-25114d02755mr11529835ad.6.1757368266771; Mon, 08 Sep 2025
 14:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aL9Ch_XaYTxMzFXK@x1>
In-Reply-To: <aL9Ch_XaYTxMzFXK@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Sep 2025 14:50:55 -0700
X-Gm-Features: Ac12FXxKKtVNXodXKUdoEQiJlG44mQVtYUYRrCCWg2KWWOvbz0x8DwTRDij0uCc
Message-ID: <CAP-5=fUYfZyvOpH2rTzMfoz0_uqmHRucwP=tgNB6=pigrowR1g@mail.gmail.com>
Subject: Re: [PATCH next 1/1] perf symbols: Handle 'N' symbols in /proc/kallsyms
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:54=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> I started seeing this in recent Fedora 42 kernels:
>
>   # uname -a
>   Linux number 6.16.3-200.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Aug 23 1=
7:02:17 UTC 2025 x86_64 GNU/Linux
>   #
>   # perf test vmlinux
>     1: vmlinux symtab matches kallsyms                  : FAILED!
>   #
>
> Rust is enabled and these were the symbols causing the above failure,
> i.e. found in vmlinux but not in /proc/kallsyms:
>
>   $ grep -w N /proc/kallsyms
>   0000000000000000 N __pfx__RNCINvNtNtNtCsbDUBuN8AbD4_4core4iter8adapters=
3map12map_try_foldjNtCs6vVzKs5jPr6_12drm_panic_qr7VersionuINtNtNtBa_3ops12c=
ontrol_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterat=
or4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>   0000000000000000 N _RNCINvNtNtNtCsbDUBuN8AbD4_4core4iter8adapters3map12=
map_try_foldjNtCs6vVzKs5jPr6_12drm_panic_qr7VersionuINtNtNtBa_3ops12control=
_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4fin=
d5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>   $
>
> So accept those 'N' symbols as well.
>
> About them, from 'man nm':
>
>            "N" The symbol is a debugging symbol.
>
>            "n" The symbol is in a non-data, non-code, non-debug read-only=
 section.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 3fed54de54016227..3d04382687d17d22 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -107,9 +107,14 @@ static enum dso_binary_type binary_type_symtab[] =3D=
 {
>  static bool symbol_type__filter(char __symbol_type)
>  {
>         // Since 'U' =3D=3D undefined and 'u' =3D=3D unique global symbol=
, we can't use toupper there
> +       // 'N' is for debugging symbols, 'n' is a non-data, non-code, non=
-debug read-only section.
> +       // According to 'man nm'.
> +       // 'N' first seen in:
> +       // ffffffff9b35d130 N __pfx__RNCINvNtNtNtCsbDUBuN8AbD4_4core4iter=
8adapters3map12map_try_foldjNtCs6vVzKs5jPr6_12drm_panic_qr7VersionuINtNtNtB=
a_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterat=
or8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
> +       // a seemingly Rust mangled name
>         char symbol_type =3D toupper(__symbol_type);
>         return symbol_type =3D=3D 'T' || symbol_type =3D=3D 'W' || symbol=
_type =3D=3D 'D' || symbol_type =3D=3D 'B' ||
> -              __symbol_type =3D=3D 'u' || __symbol_type =3D=3D 'l';
> +              __symbol_type =3D=3D 'u' || __symbol_type =3D=3D 'l' || __=
symbol_type =3D=3D 'N';
>  }
>
>  static int prefix_underscores_count(const char *str)
> --
> 2.51.0
>

