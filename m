Return-Path: <linux-kernel+bounces-722286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3D8AFD75B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08031BC4621
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201EC2367DC;
	Tue,  8 Jul 2025 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wetterwald-eu.20230601.gappssmtp.com header.i=@wetterwald-eu.20230601.gappssmtp.com header.b="GMirxosY"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96CC223DCE
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003900; cv=none; b=SAKF25maKAaefbYGXyFw27WfAWRzfHYGCS+RKh1HKNEOuZ2vDsjddEcCl7diXdHaedbz0VkzltQrTSHhi1Wk9KT1QxGj1XrU2ZmnPsQPxKmtok3Nmvs8TsK7n+XKYw/0J1WLkk7ljFLX9JBf8BapkfT9CpTPxG4YlD1j3ZNH3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003900; c=relaxed/simple;
	bh=mqQvmbpVSpwd4BJxpTbMnhfC49JhmthGVhf3kBQWduA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XzpQsQel+naVqdoel4fEk3foWItnniogK2p1jsI+VC1g81448rtwc2e2dnNS3AIo/sV2Yx/0GErddtX03bQ7WbGVSoSASLKWVuPV/TP9EZJOJ20ZYO/tmAnV2cqAtJFprSIf2PwGBmcXxWn18ROv7QK9XJuzclkoS7XMP7devgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wetterwald.eu; spf=pass smtp.mailfrom=wetterwald.eu; dkim=pass (2048-bit key) header.d=wetterwald-eu.20230601.gappssmtp.com header.i=@wetterwald-eu.20230601.gappssmtp.com header.b=GMirxosY; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wetterwald.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetterwald.eu
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b3316160so5620180e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 12:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wetterwald-eu.20230601.gappssmtp.com; s=20230601; t=1752003895; x=1752608695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WIAuhguJbjbIbOUTc3BpFRhCievia3W8jmk4iJLHgNI=;
        b=GMirxosYFGN3allPlLzWfdPYPc07Q3kQlw5gexgWPnJA4XQrMnfgG+4KvzFJYbykI6
         NqAet9CjmVOZ8DF5kq/68ebeQAXxhj2P79Ey7LpcmVYho5J0g2Piv0Z9l0UJ2iPUI6Wj
         M0Lag/N+1cN065dMPzcZZRbzOP7YVRUTQVuxmRTmS/1MDeronRwd1dqj2yteOht1ypXs
         lFS43Y/bF3XKWrzCjiGHvmaW1x5K8bzvDVvYxhXGz24Mtz5V3D4xPbibF0he7QCJTKux
         gtqm9Je6/zvOHGxJ/e7GMxZawZVBdmOf6Yi+JBntBT+yVNzd/nr2gz2COnP1E2mxhLuN
         jBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752003895; x=1752608695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIAuhguJbjbIbOUTc3BpFRhCievia3W8jmk4iJLHgNI=;
        b=G7teawpbOhdbMVo3SP+F/SNrrFfa/aFyQCeAtEFx0H1LW66cRpy32WJxgyTe+RhfYI
         lyM5FwgvutZdvTBylIp3UlptrQJccPxbFvku/kjcetbWXazlk5shJKoM5t/Uzf1vszZA
         8Ev6VY81cc91r2Kz0X9z4N2lRrh6oahZa7XD+araLcKeeF8UnsmtQKV/mtu2e/jw0WF3
         4bMOknFgAMv+4afi5Xw0hsYYV+rDqThEeh6oRomGaKonq78uMFxi4SDj6IoNwOb2cljZ
         dvUkPxaMIvAj89SnIguuAaNEexDVPrZlRj2bacXZcRmTPg5idLRKxoTqQMfB6U9xzl1H
         RJzA==
X-Forwarded-Encrypted: i=1; AJvYcCXUnMBa6KOMh9Weqf7+c9HbB6frqCmYRPtJWLIpzyXpcDyi7zU0AuvnGuij8Ta754q7No6VGvIh/3/OB1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YygSnUnzfSdkZzqMVLoucTdFYVZXiXlE4caqCp0LKTQWe4uuBXV
	BWoDj2U0yhG1LLU4r+Sh+SpcbgOSeocAYxd3mptXeKfLX9xIqD8o6tKTImKi2Tb2Z8PVP2Mg/SI
	VLypS+tDY/nnSXuaBt8ZEptueOjxi6wkq4OZgsB5sgA==
X-Gm-Gg: ASbGncuiVtgz1QTOXHNfTzcVWeRjU23uk3zYmo7tTAjnvS/viobwR0RaFw+qzqYI6Lk
	Re3LokNsy8TD8RoCHpZchZKQ8nX6mHEjs7eWosOxjMXACw3wV//7EsP0XWIBWLsO/nmaBqdTp/2
	ZZRHciPMbqvPKrPTLNjNMncP+GTxx/2UkSaxtiIZ5oJEbjnBYLGu37b/7dwju4Af8Lmmb6W6wrF
	fo=
X-Google-Smtp-Source: AGHT+IH/OYi1zhVRzbLWoXiGDXL/pwIwshawu+yWzAP5+4Np+28rT/YVvWgXf9ePBLccE4OypTRTipSLI44R0xQmhvU=
X-Received: by 2002:a05:6512:31cf:b0:553:246f:d5cb with SMTP id
 2adb3069b0e04-557aa964099mr5151783e87.40.1752003895281; Tue, 08 Jul 2025
 12:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wetterwald <martin@wetterwald.eu>
Date: Tue, 8 Jul 2025 21:44:44 +0200
X-Gm-Features: Ac12FXwxStEw7-ASRfno3Jq6d5Qa6fuSc5X61ioxY7IDp_eLCz6XHk1FLyE_E4I
Message-ID: <CAFERDQ0zPoya5ZQfpbeuKVZEo_fKsonLf6tJbp32QnSGAtbi+Q@mail.gmail.com>
Subject: Linux linking stage broken on ARM with binutils 2.33.1 (BFD)
To: linus.walleij@linaro.org, Nathan Chancellor <nathan@kernel.org>, linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

When I upgraded from 6.12.22 to 6.12.23 (without changing anything else), t=
he
linking stage of vmlinux broke (arch ARM).

> /home/.../linux-6.12.23/scripts/link-vmlinux.sh: line 49: 136961 Segmenta=
tion fault      (core dumped) ${ld} ${ldflags} -o ${output} ${wl}--whole-ar=
chive ${objs} ${wl}--no-whole-archive ${wl}--start-group ${libs} ${wl}--end=
-group ${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
> make[2]: *** [/home/.../linux-6.12.23/scripts/Makefile.vmlinux:34: vmlinu=
x] Error 139
> make[1]: *** [/home/.../linux-6.12.23/Makefile:1179: vmlinux] Error 2
> make: *** [/home/.../linux-6.12.23/Makefile:224: __sub-make] Error 2

This patch seems related:

> commit 59fc42318305cb38efb4f5565408150419be8451
> Author: Nathan Chancellor <nathan@kernel.org>
> Date:   Thu Mar 20 22:33:49 2025 +0100
>
>     ARM: 9443/1: Require linker to support KEEP within OVERLAY for DCE
>
>     commit e7607f7d6d81af71dcc5171278aadccc94d277cd upstream.
>
>     ld.lld prior to 21.0.0 does not support using the KEEP keyword within=
 an
>     overlay description, which may be needed to avoid discarding necessar=
y
>     sections within an overlay with '--gc-sections', which can be enabled
>     for the kernel via CONFIG_LD_DEAD_CODE_DATA_ELIMINATION.
>
>     Disallow CONFIG_LD_DEAD_CODE_DATA_ELIMINATION without support for KEE=
P
>     within OVERLAY and introduce a macro, OVERLAY_KEEP, that can be used =
to
>     conditionally add KEEP when it is properly supported to avoid breakin=
g
>     old versions of ld.lld.
>
>     Cc: stable@vger.kernel.org
>     Link: https://github.com/llvm/llvm-project/commit/381599f1fe973afad30=
94e55ec99b1620dba7d8c
>     Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>     Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>     Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>     [nathan: Fix conflict in init/Kconfig due to lack of RUSTC symbols]
>     Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I'm using BFD linker from GNU binutils 2.33.1 (built using musl-cross-make =
with
musl 1.2.5 and GCC 14).

> scripts/ld-version.sh /tmp/arm-linux-musleabihf-ld
> BFD 23301

I don't know if it was the intention of the patch, but it is not only chang=
ing
a behavior for LLD, but also for BFD:
- Before the patch, ld BFD 2.33.1 was not selecting
  HAVE_LD_DEAD_CODE_DATA_ELIMINATION, and my build worked.
- After the patch, ld BFD 2.33.1 is activating
  HAVE_LD_DEAD_CODE_DATA_ELIMINATION, and it is segfaulting.
Shouldn't we keep the previous behavior and only select this option when BF=
D is
>=3D 2.36.0 (and not just when we have a BFD linker) ?

The issue is the interaction between LD_CAN_USE_KEEP_IN_OVERLAY and
HAVE_LD_DEAD_CODE_DATA_ELIMINATION.

Nathan, I've seen your proposal here: https://lkml.org/lkml/2025/7/5/431.
I confirm it also fixes the issue on my side. Should I propose the patch?

Thanks!
Martin

