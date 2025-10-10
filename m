Return-Path: <linux-kernel+bounces-847659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772ABCB5DE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59AE3C78F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81D2222C0;
	Fri, 10 Oct 2025 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY0cskXN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310962868B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760060523; cv=none; b=c6PYRccvad6Dj/Qk040zoV34CAeNO6673cVM8kB2TA0h4G798PXr2OqJuC4PV1Vw+K0i5eXzYxslTdVI6V8rzKvBPrTgAJJ93o1k9f0lT8bv5HXATnEFiupJHhPD5Y3exzYhXlWBecmmwgpXizEIMzeQ4Gx4bxGEap0GYjZFkL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760060523; c=relaxed/simple;
	bh=A9TFfCDF9pgAE/Iw/EyrIDrgCMm7RRP98Y6zVUsNlaQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H01Pxlb0Sk6juCVSEw8yDblLxF3yuNuF1NCtj4/OyDWKAu3WfzxnJa+Yb+LW3JsxlbyV+7GE7AOnhedg0GwZofSPTCN+zB8mNPEqYyxuk/J/6gfIhEwePxzrbLLuVQQKpZ2xX1BdrCTpqEE6zMQuPAbiZ3feBTyLqDH8/spvQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY0cskXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376A9C4CEE7;
	Fri, 10 Oct 2025 01:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760060521;
	bh=A9TFfCDF9pgAE/Iw/EyrIDrgCMm7RRP98Y6zVUsNlaQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lY0cskXNfYWfgiFHNCyWlAODQqRTCvkg/E5aTp+2nHiQ9wUnUcHN1XJSZ3NFMxRLA
	 mp4lFpyMKdbkM9dYi9d7URhNL91ViSvOqdvrKYlh+SrrL1hDSMHTouLlxLrg4BlHSL
	 zHWvWscmv0mtP03PkWroCB5N9LVZI8tEHr8jWIyb3U8gcAy+3HtOeGEYlDwMIYeOsr
	 rnGoxGzH+ifM74p9FpS8f22AyDlgnQLlLDFHBCMsYSQ1AoeKBTPZDxOhoAH4ZZ2dqw
	 78fb1svL8n98fvmFVL0TdBr+UZIHkW+bvlZXmzHkTixcMOnCam6FPedyiLxFXFjiUc
	 HgmKaREhYpCEA==
Date: Thu, 9 Oct 2025 19:41:58 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Svetlana Parfenova <svetlana.parfenova@syntacore.com>, 
    Kees Cook <kees@kernel.org>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Respect dependencies of
 ARCH_HAS_ELF_CORE_EFLAGS
In-Reply-To: <20251009-riscv-elf-core-eflags-v1-1-e9b45ab6b36d@linutronix.de>
Message-ID: <9f4a3f7f-7954-f7a9-dc72-919b37adf3ce@kernel.org>
References: <20251009-riscv-elf-core-eflags-v1-1-e9b45ab6b36d@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1481120612-1760060521=:2116846"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1481120612-1760060521=:2116846
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 9 Oct 2025, Thomas Weißschuh wrote:

> This kconfig symbol has dependencies and is only selectable if those
> dependencies are also enabled.
> 
> Respect the dependencies.
> 
> Fixes the following warning when configuring an 'allnoconfig':
> 
> WARNING: unmet direct dependencies detected for ARCH_HAS_ELF_CORE_EFLAGS
>   Depends on [n]: BINFMT_ELF [=n] && ELF_CORE [=y]
>   Selected by [y]:
>   - RISCV [=y]
> 
> Fixes: 8c94db0ae97c ("binfmt_elf: preserve original ELF e_flags for core dumps")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Thanks Thomas, queued for early v6.18-rc.


- Paul
--8323329-1481120612-1760060521=:2116846--

