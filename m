Return-Path: <linux-kernel+bounces-874461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758CCC16634
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C661B22ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1596834C9A3;
	Tue, 28 Oct 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs3woLT9"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B8217F31
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674731; cv=none; b=joGTVxabonhpBsu9MKmU+xiPvIU5l1QfEdLvbNVLJHXjzBQ7XsSD1sKOATLU5EvtBe7KoY+BCt9TYpE96lwxFhgJ4kecqaweT6qvnAe/bRAkpHfqKWlSrCy1lnhKBcufFgnjEo36OMzPcZAHGYlaUmHR4OxzSjslIZwEN7Y1kYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674731; c=relaxed/simple;
	bh=cn/C25Rbz1g7ApkaIAu6c0yNtzInMistPhKCeEWzQMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsrUKPl68qNjOdQGv80KPRrBejRo3acKVUAq1tmpO5VYvAyWqjCJ4AshE00kZMKNNe2f0xZ2Yc/Dusofsrbgn6kVHBQcRyIGSmfhSN+pMoG/I2AHkH0gcRJAuG1aLO+UhZ+5VRN3zhHFHzkjMeI9FYcpHv/ARL7jxkgjMwdWQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs3woLT9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so6181442a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761674729; x=1762279529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yk6w8rVYaZcWTSTnE7iPwtQqPowVrL1jgYD+HQnj6UI=;
        b=Hs3woLT9P6CfNwm6zmoW+BWsTMRdxwHNk7VjdvMXUUiCmeQXpYIvJaMWXvFTOce+zk
         0bfeZVdepvmZ7wv+7fNtNDG7qCtWrqtlN+cITVFnlgUZfUa4Jo4ulrv9yWXbNUVlabls
         gwwGrEvQC7ZYHuQXfHV6Vm064uKRQH9gFU2eHAb5CuIfy/m1y6m2Nq1K17nbKHZeleXE
         06mr2thlk6C7dKfAY4LYZhg1NpB7SoPC1eS2MinA+jFTlk4siQAt+CxhewBdIQJRpDTU
         iupTW7KDxwKfna+LK2sHSYs6SEGmitc53H7cBwtuh2QhFatxVreUCODKHT0ZxIb1OW5z
         VLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674729; x=1762279529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yk6w8rVYaZcWTSTnE7iPwtQqPowVrL1jgYD+HQnj6UI=;
        b=fLzIoRt1/SjDNhmHTq/A36HfaIwZ3lM+v6sxTqFELtXRevBNAy41s1uFZzR7GoXIp+
         3l17clH6NZ4T5/lqygqoPXR6ARN8qwmjy01XJuIO4rAqTGb3ZaNz97+zVvJbFOlSg3R2
         ozxW7g643nNVsyX3pJjgDo4YpPx1Xcn8hJURl0Qa7b2OVJUIFpUzrFe2awp/asyMKtVN
         OqN/pEEKEBUPFIrPIrvoVBPNuUO+7odEyEgN8E9n+sBA8d1TMy3iq7/gd3LgqhipUHjP
         CGDzLF/39kWRHXLxNo1nhD72hO0ey319FTgq3nNtIOt8TLYOtEJ0Jmh0rYYMQghlt0mH
         gFVA==
X-Forwarded-Encrypted: i=1; AJvYcCWwJO8PjsKyxKqnlaipXgOgll6fqFGFgu6iExLhQQMnsae4wbxljmCQp2pKJnVr2X8WOk41jabA5Z3O5bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPlkE1J8aBb3VuGB8ErK3AzruXG5QFasxLEWSTK8VBUmBvEHVD
	y67sotDAIVDU+1L4MehAADRcb8mV2QghWn/QIAv2wjkBMm//FPFYH+SS1DhrUp7bMMmw8rJJSXp
	rodmTaOX8srTcRPg3li1Ric38y442gew=
X-Gm-Gg: ASbGncunVte87C6Lw09C4psTY8IM86eW51y3KEWRIgoQSTRKHBUc/s2fvvrkgEFxM7O
	gAdC6uclJ3f1DEAIJS5M3Mj/t//aco0V78pO86o/rwBHT+W/bU8ONJUgq1Vv4Hznjk9ZJamstXO
	wLIWTdUe+ncrec1fkVF2owMvLJmJbQ84HCRKE2alxVbSQAVW3oIzkysn8+rolkrA80SKZ1A4OXP
	+P5BSAH1/XoYIrgcb0+5lvI4vCtnQVg32e8n751NhKiLTs81s/R/gnvavcRVUZWEqiikl2gqpBl
X-Google-Smtp-Source: AGHT+IGDWFPgY7P0J0rgoNRTpXkV9IpxvVzPeFO9NpOmpx7n8IIeQPH2id5pD0zxVQQqtPdTX8VbDivieGgcF2cpwKU=
X-Received: by 2002:a17:90b:58ef:b0:33b:c5f6:40ef with SMTP id
 98e67ed59e1d1-34027bda889mr5099562a91.24.1761674729195; Tue, 28 Oct 2025
 11:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028135732.6489-1-cuibixuan@vivo.com>
In-Reply-To: <20251028135732.6489-1-cuibixuan@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 11:05:14 -0700
X-Gm-Features: AWmQ_bkJMeV6sNPrCRGI7CcuEc5yewkxYrithOiGgXmBNzkm4G-mk86H_tT3dWE
Message-ID: <CAEf4Bzbp2FYvTVz6SStj_p_ok+LLeXEAxcUiCkyWRf3wyjwi_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Ignore the modules that failed to load
 BTF object
To: Bixuan Cui <cuibixuan@vivo.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 6:57=E2=80=AFAM Bixuan Cui <cuibixuan@vivo.com> wro=
te:
>
> Register kfunc in self-developed module but run error in other modules:
>     libbpf: btf: type [164451]: referenced type [164446] is not FUNC_PROT=
O
>     libbpf: failed to load module [syscon_reboot_mode]'s BTF object #2: -=
22
>
> It is usually skipping the error does not affect the search for the next =
module.
>
> Then ignoring the failed modules, load the bpf process:
>     libbpf: btf: type [164451]: referenced type [164446] is not FUNC_PROT=
O
>     libbpf: failed to load module [syscon_reboot_mode]'s BTF object #3: -=
22
>     libbpf: extern (func ksym) 'bpf_kfunc': resolved to bpf_module [16444=
2]
>     ...
>
> Signed-off-by: Bixuan Cui <cuibixuan@vivo.com>
> ---
>  tools/lib/bpf/libbpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 711173acbcef..0fa0d89da068 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5702,7 +5702,8 @@ static int load_module_btfs(struct bpf_object *obj)
>                 if (err) {
>                         pr_warn("failed to load module [%s]'s BTF object =
#%d: %d\n",
>                                 name, id, err);
> -                       goto err_out;
> +                       close(fd);
> +                       continue;
>                 }

It's not an expected condition to have kernel module with corrupted
BTF, so I don't think we should be doing this.

pw-bot: cr


>
>                 err =3D libbpf_ensure_mem((void **)&obj->btf_modules, &ob=
j->btf_module_cap,
> --
> 2.39.0
>

