Return-Path: <linux-kernel+bounces-870043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39690C09D04
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47B31583A84
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BCC2E9EAA;
	Sat, 25 Oct 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFMdd1HD"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA1A2F5B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410227; cv=none; b=P0j6ZUbZpfLUTEsYURvN5QE7Z3CNKUQ7gJBZx8DImSu+KPMrQVAB9G9a8oz29huCHqO9IgnffCtvFOdWpr57cxqBDgb7gDMjJgTf5iNOSeep5aHdyhHUIgRGO8TMkqUBMvPqQcS8lySMLUFNrWhYi13/1NzjxVLeuNfUGR4d9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410227; c=relaxed/simple;
	bh=Vq5UC3S+Qa9vDIbkzi9fCvhdC7hBqMC5Z9lmwN9lANw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfXr8D8lSWbmsCIcabYS70S66EpwXPp99Muqk3STshhYDs4DGJm0ZFVJ0oDb4zkyGdU0SOOJfg8HXmnbwloCyfBfyjV1rM26f0TzsJwpRjA78Eu0TRjKBdb16d6e1MZckOq6xzla085JnhGNAsrM3D8va4fX2ERtaSVr1XhLLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFMdd1HD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-89048f76ec2so357348885a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410222; x=1762015022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9N6S7T6py8PeRj/rOtZbhhJaooq6y8nSlIhgmi1OV0=;
        b=MFMdd1HD6PPcXuTJo5WOJCrCpECwKbCP+y3c9kdotabEC+YQBAPh1jd8VetOS6qXHg
         MRrv9FkpIVLz+No43CSp4iaWFCPYHwveOIAgoyMk+racBTehbMLjrFkVBhNiWJMUiK2i
         3aHIabfydNNjZpLTVVw6uAnlSJPrFYaScEeGmpJcA8Tx/1y0xTpg37M9s600zjIX2bHr
         bJp+AyoX6Fv3jcBGYLVgdAs0Kq4n0+yRwyniNV0lRXiQiLA0S6ncRBD1E6lUOe1sodNq
         yfzjQkKhyaFScWjsI6d3Uqm+vgVioN3jbk2BfsBvMglZo/KOTcKJrk3dQRTYbmQPZcF3
         2itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410222; x=1762015022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9N6S7T6py8PeRj/rOtZbhhJaooq6y8nSlIhgmi1OV0=;
        b=bOhFKlshRxO9MpsgN7NONZxDsEXj0regLNCBjSBiSL8HLIvcS5xLyzcuvj05drojGa
         0jExpaZxbkgi3BxEo+GP2jhj+Dc3z2CGiRFwCN6GOvZbL5Zip67MxtcKI0/fLU33DhtF
         yvYNOKbo6rsn7aT/nOqmIfGixY+TN2coBBzOFZ6eUgmnkLPTIzgSKzKrUi2IGz2U/xjX
         MsG3brhPq7OJzXotmkFELQdwjhvDc96ACfWZodJUK+d6erJ87LL3/T5eLl81xzcVhdG1
         VxoKTNRNtL91IQV5x9eeUWUbcOsWTtCf1Rj+tP0L3Hgg8h0V3CarCjdHy7atydVTeUao
         r9Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXtIYlWLX2s1+Qs6fhpTUoHrkMjegfvHOBXIaX3SQyxPXB8E6KCMMoa/+ojsGFEmlqct6XYqhZSc8PTpQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSI01tRUUah7idQjw3/1/kL3qdn5ielflQDA5c7/xgrupmQNlg
	zwNm887HyDNN4Tl8nCmrBF6Oy4RzedHJImK4JaNuS4I/o9VG2cVcd0D1
X-Gm-Gg: ASbGncvjSKk/cavjNRePjKsNnQHorpca65Ln+GD1EZzn1dRwVz2BYiEiE8MFXaNBQ8p
	/+WnlOxP/PJdp2AvjOZoLcoEtKMkhoMeyzXD55+Ym8EhUxTg1JJ76rHmGp4OKpS78SuWNlr3vSB
	vp8bKyxTaSE4NXBZDdYP937BYwrc+lPcZUzHNKoCyVOq0/06Sun6Bne9iLAwhmm6mu+2491Wye+
	JubBWTf93CrIDgLetTKRq3W7seR1dcbvg2ZIoqIwkpGqiI2T6U5FxuSdYr87W9gNmSbJY7SoqS3
	+ITJ3dq90nqz90g8BQLXwDyu9wPz68002ZlfQujWN7DALFQ1LMLMz6jumSeu6H8BfW87E8NXV1o
	iq7nsM7/iLX47LaIE4wp3u8J2Coo7LXLU7OqtClttYU2CTReWNCpyYddWA7N6A3EEz/r20/Y3
X-Google-Smtp-Source: AGHT+IEtna3VdNFsNRGPPO1rRNNfH6lAa3G7+dTJJNdTKpS4A8PpY3/x/91ajSxp87X+6s24Ykc4yw==
X-Received: by 2002:a05:620a:a09a:20b0:891:da6d:307c with SMTP id af79cd13be357-891da6d30c3mr3681242485a.27.1761410222169;
        Sat, 25 Oct 2025 09:37:02 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f247fb582sm173627285a.12.2025.10.25.09.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:37:01 -0700 (PDT)
Date: Sat, 25 Oct 2025 12:37:00 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/21] lib: add alternatives for GENMASK()
Message-ID: <aPz8rC-F_xYrf03N@yury>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>

Please disregard it. The patches 8-21 have the TO list corrupted. I'll
resend shortly.

On Sat, Oct 25, 2025 at 12:28:36PM -0400, Yury Norov (NVIDIA) wrote:
> GENMASK(high, low) notation reflects a common pattern to describe
> hardware registers. However, out of drivers context it's confusing and
> error-prone. 
> 
> This series introduces alternatives for GENMASK():
> 
>  - BITS(low, high);
>  - FIRST_BITS(nbits);
>  - LAST_BITS(start);
> 
> Patches 1-6 and 8 rename existing local BITS(). Patches 7 and 9 introduce
> new generic macros. Patches 10-18 switch GENMASK() usage in core files to
> better alternatives. Patch 19 adds Documentation section describing
> preferred parameters ordering.
> 
> The series is inspired by:
> 
> https://lore.kernel.org/all/CAHk-=whoOUsqPKb7OQwhQf9H_3=5sXGPJrDbfQfwLB3Bi13tcQ@mail.gmail.com/
> 
> Yury Norov (NVIDIA) (21):
>   arc: disasm: rename BITS() for FIELD()
>   iwlwifi: drop unused BITS()
>   select: rename BITS() to FDS_BITS()
>   ALSA: rename BITS to R_BITS
>   zlib: BITS() to LOWBITS()
>   mfd: prepare to generalize BITS() macro
>   bits: Add BITS() macro
>   mfd: drop local BITS() macro
>   bits: generalize BITMAP_{FIRST,LAST}_WORD_MASK
>   i2c: nomadik: don't use GENMASK()
>   drivers: don't use GENMASK() in FIELD_PREP_WM16()
>   bitmap: don't use GENMASK()
>   trace: don't use GENMASK()
>   lib: 842: don't use GENMASK_ULL()
>   bpf: don't use GENMASK()
>   kcsan: don't use GENMASK()
>   mm: don't use GENMASK()
>   fprobe: don't use GENMASK()
>   fs: don't use GENMASK()
>   fortify-string: don't use GENMASK()
>   Docs: add Functions parameters order section
> 
>  Documentation/process/coding-style.rst        | 48 ++++++++++++++
>  arch/arc/include/asm/disasm.h                 | 62 +++++++++----------
>  arch/arc/kernel/disasm.c                      | 46 +++++++-------
>  drivers/gpu/drm/rockchip/rockchip_lvds.h      |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c  |  4 +-
>  drivers/i2c/busses/i2c-nomadik.c              | 44 ++++++-------
>  .../platform/synopsys/hdmirx/snps_hdmirx.h    |  4 +-
>  drivers/mfd/db8500-prcmu-regs.h               |  2 -
>  drivers/mmc/host/dw_mmc-rockchip.c            |  4 +-
>  .../net/wireless/intel/iwlwifi/fw/api/coex.h  |  2 -
>  drivers/soc/rockchip/grf.c                    |  4 +-
>  fs/erofs/internal.h                           |  2 +-
>  fs/f2fs/data.c                                |  2 +-
>  fs/f2fs/inode.c                               |  2 +-
>  fs/f2fs/segment.c                             |  2 +-
>  fs/f2fs/super.c                               |  2 +-
>  fs/proc/task_mmu.c                            |  2 +-
>  fs/resctrl/pseudo_lock.c                      |  2 +-
>  fs/select.c                                   |  6 +-
>  include/asm-generic/fprobe.h                  |  7 +--
>  include/linux/bitmap.h                        | 11 ++--
>  include/linux/bits.h                          | 11 ++++
>  include/linux/f2fs_fs.h                       |  2 +-
>  include/linux/find.h                          | 34 +++++-----
>  include/linux/fortify-string.h                |  4 +-
>  kernel/bpf/verifier.c                         |  4 +-
>  kernel/kcsan/encoding.h                       |  4 +-
>  kernel/trace/fgraph.c                         | 10 +--
>  kernel/trace/trace_probe.h                    |  2 +-
>  lib/842/842_compress.c                        |  2 +-
>  lib/842/842_decompress.c                      |  2 +-
>  lib/bitmap.c                                  |  2 +-
>  lib/test_bitmap.c                             | 14 ++---
>  lib/zlib_inflate/inflate.c                    | 48 +++++++-------
>  mm/debug_vm_pgtable.c                         |  2 +-
>  sound/core/oss/rate.c                         | 12 ++--
>  sound/soc/rockchip/rockchip_i2s_tdm.h         |  2 +-
>  37 files changed, 235 insertions(+), 180 deletions(-)
> 
> -- 
> 2.43.0

