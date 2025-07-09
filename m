Return-Path: <linux-kernel+bounces-723856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C430AFEBC6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D966A5C18E1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166062E541B;
	Wed,  9 Jul 2025 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="En6twdF/"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA428ECF2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070371; cv=none; b=aSH9JdB7/+KQE7GGYInfGDeXzGy9XVUgn+QPGUxSMt9DnrDHb1m9x190hqjJkbYaGW84YwOkACqk4eG+6shhBiBJzKUECoh35JWW29J8hc8cReWOUFFLyF3rXPJh36dS92mxHXdHPdG73kM2oWBP2zz9aNksYixz8HL8bCF83e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070371; c=relaxed/simple;
	bh=llGGVVKA1oT1cZN3rlDyVVLXljRITRYkWgThTYOXwb4=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=mK4UMHnP+4krKQYOJxdWDqsh8PcZ+OX6WZLsPE9G6Nu32WP6E/of0PqoYbK43qq/KUqAe4hFP+HerrBZ+GS2MjQsjG1k+gCh5Y4aUdZnKQlU9bQlLtxrLb/iPPp7QB9dg3AnQYZPoPDRQAz9SbU5Yfc2cJ6zBWj9lYuc2RIVLUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=En6twdF/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23508d30142so67851155ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1752070368; x=1752675168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sh1G9uIyIrM8UVHoGgJ08SC2aKmJgvWNLWkVXNGTe4=;
        b=En6twdF/D/TmItdKfNtLqD3lhNsvH+OhDxfaXu6GTZj9FFVTX2FcTHllh9FR+QorD8
         tBDfW5fy/r9yk7JN3GFh4yf5ht1Sq2bEOVnxGxp4iNen3Xx25wmTq8sQbJkRY4fYr188
         Ci/EcgcEpqHLcj9m75qvLcgQHvlGCxQsB7H/BL5P1EgErsZOmiejSrn9akCyJcmAo01E
         veq/X9a8ADlBWXU4vtdf7XPFFvHyoH1lA2fdH1DsoB667y7/kiuzCE51ZqleGOBs3l0t
         Phetdqj8IRjy7gWgOalAMy6VOhsK3vOsbukXmeEkCNA9zDq/82BdB8wp4udo8huTNy/z
         epzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070368; x=1752675168;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sh1G9uIyIrM8UVHoGgJ08SC2aKmJgvWNLWkVXNGTe4=;
        b=GBCIEVqgYdTUAiaOsAwPoupmlka20E/ch/eEqY31GiKwdfI2frI278GgtaehEb40BZ
         ZO4JwtnOlCbfmF70UBXzB7g6HVMq8qLAFMHEYR6brkEjqMgLTyn0redfnDHp5sA0iFx9
         /crTxgD22GAP1SLsJnPyciMz6S8h6M5ViRSSts6X7Lqc9fKBrUf9yd/IOBZdhlluRV95
         6wFCZoh6CWFoEEBLuKlAFS2e7OfZSqw6UagX+dVAsHNxZa9ueZPWGIqFaurB3ba1xFlz
         P3iR62D68hqLtNCqn9IDTDvngP7FW8dIuIlV4HleBz6F1nvBVTJWyE9TCh+PfPw2XUR9
         PhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZnknbMydqAOt+ESZ82HoR791vWWu8eKuL0e4NcX6UPi8LZLvzHYVGFdZy3NFPuUup1z4Kv4xxuBl42kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzitVp+SdQQa5uX8DESX+2D960zJ1kRY+LbOaHn0mxL1GYy56rw
	KpVEkI13CuuPdNO/7mdBcy2L1YZNGC5t9BLk9mcqte4kjdBXshZ6bbYCvpsoH/mNv8I=
X-Gm-Gg: ASbGncuJbnemqHGrkB1EWu7xsrzNb1yDpIBAQdhq2KGZL8nTjmPDSiNEv1dEkVFfCxR
	J6keeCHtORxOrz+d96peapDHkY3EkH3fgLWohC0LXIn1IfIrOF/2zbFTtsH1qNktXnek1l/kzrz
	rzIR0oYs7DMfTu1oHouP9m+sS1IKIXrSh+OXOY2ndKU/94qFTSDy4FbNZNaDtR09p0l/ON1egu8
	AD1GEID2HQVMP9xnz6H1oiiLzs685ca7I5qxoa7Qv8jFbyFWm2PW/xiN6XfJoB5mZ/dlbE+SlG/
	x+eMq7Qg8eNvgV63RTqgjwY7wgbgLBkV27TjLgj4KM63pTmlA4gF18vRzFkx
X-Google-Smtp-Source: AGHT+IHi6+p1+2PoHOilD16rPwmlo4mLHV2Z957WubESw5P4eL10+2uXRGzrnzQf+fdNsRPxpzdLkA==
X-Received: by 2002:a17:902:d2d0:b0:237:7802:da30 with SMTP id d9443c01a7336-23de24d48e2mr986145ad.31.1752070368282;
        Wed, 09 Jul 2025 07:12:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::7:a219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8431e1b0sm140531525ad.44.2025.07.09.07.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:12:47 -0700 (PDT)
Date: Wed, 09 Jul 2025 07:12:47 -0700 (PDT)
X-Google-Original-Date: Wed, 09 Jul 2025 07:12:45 PDT (-0700)
Subject:     Re: [PATCH] riscv: ftrace: Properly acquire text_mutex to fix a race condition
In-Reply-To: <20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com>
CC: rostedt@goodmis.org, mhiramat@kernel.org, Mark Rutland <mark.rutland@arm.com>,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, Alexandre Ghiti <alex@ghiti.fr>,
  linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  rabenda.cn@gmail.com, wangruikang@iscas.ac.cn, ziyao@disroot.org, alexghiti@rivosinc.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alexghiti@rivosinc.com
Message-ID: <mhng-6AFAE150-B97C-493D-9699-545AABAC78FD@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 08 Jul 2025 01:33:48 PDT (-0700), alexghiti@rivosinc.com wrote:
> As reported by lockdep, some patching was done without acquiring
> text_mutex, so there could be a race when mapping the page to patch
> since we use the same fixmap entry.
>
> Reported-by: Han Gao <rabenda.cn@gmail.com>
> Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>
> Reported-by: Yao Zi <ziyao@disroot.org>
> Closes: https://lore.kernel.org/linux-riscv/aGODMpq7TGINddzM@pie.lan/
> Tested-by: Yao Zi <ziyao@disroot.org>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/ftrace.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 4c6c24380cfd9d6c51f0e4340cd674160b83a610..22e7bdf8de2b6ca950cf2c8b734bc82ea46ba8bf 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -14,6 +14,16 @@
>  #include <asm/text-patching.h>
>
>  #ifdef CONFIG_DYNAMIC_FTRACE
> +void ftrace_arch_code_modify_prepare(void)
> +{
> +	mutex_lock(&text_mutex);
> +}
> +
> +void ftrace_arch_code_modify_post_process(void)
> +{
> +	mutex_unlock(&text_mutex);
> +}

IIRC there's a reason we don't do it this way, we had (or had tried to) 
have it before.  It's been a while, though, and I'm just having some a 
coffee so may I'm just wrong...

>  unsigned long ftrace_call_adjust(unsigned long addr)
>  {
>  	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> @@ -29,10 +39,8 @@ unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
>
>  void arch_ftrace_update_code(int command)
>  {
> -	mutex_lock(&text_mutex);
>  	command |= FTRACE_MAY_SLEEP;
>  	ftrace_modify_all_code(command);
> -	mutex_unlock(&text_mutex);
>  	flush_icache_all();
>  }
>
> @@ -149,6 +157,8 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>  	unsigned int nops[2], offset;
>  	int ret;
>
> +	guard(mutex)(&text_mutex);
> +
>  	ret = ftrace_rec_set_nop_ops(rec);
>  	if (ret)
>  		return ret;
> @@ -157,9 +167,7 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>  	nops[0] = to_auipc_t0(offset);
>  	nops[1] = RISCV_INSN_NOP4;
>
> -	mutex_lock(&text_mutex);
>  	ret = patch_insn_write((void *)pc, nops, 2 * MCOUNT_INSN_SIZE);
> -	mutex_unlock(&text_mutex);
>
>  	return ret;
>  }
>
> ---
> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> change-id: 20250708-alex-fixes-1e719b9899f3
>
> Best regards,

