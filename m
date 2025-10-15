Return-Path: <linux-kernel+bounces-853698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 001E8BDC5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5744D19A05F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604D2BD587;
	Wed, 15 Oct 2025 03:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct/h+jGW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB926FBF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499472; cv=none; b=fuFa9NIiXvIGJEQpgNfWEDmBfJphhzdA/wSmWnFrcGttBB+z8CW65Tgw98VdZP5QroA6Q5FifJ2lRICVfPl8Nv04Ux8J9GgPS04zyeZXrsXoTWZqXjQG2I4wO3mrVfdrWiCFpRBTjULwDyK18CHqTHHg/FqqcYgZ99496HeVDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499472; c=relaxed/simple;
	bh=sWZ++ZKI5PvBaF1zudgHniT7o5gWllCQAH6AAoFLBjU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KXHdh08S0j1LLBYVpjWfViUKCDCNhwpKBFi3JZNMhpYqRTZ6sGpXx+NZ7Ix3xZnPna13Q3UfD6PSMBanOMLFCfvYOiEVL93QNf6yBRab8YX1ojI/y4iSrV2/D0BPUNUepyvfDFrg51ViChhvesKXsbVbuE9gTXBAwiH8w9Jdheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct/h+jGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EF7C4CEE7;
	Wed, 15 Oct 2025 03:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760499471;
	bh=sWZ++ZKI5PvBaF1zudgHniT7o5gWllCQAH6AAoFLBjU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ct/h+jGWOlifGQ6fq1o+V+tzON7mkNfRACGz1ohUoU97OMlrm+ylzF/OBWCVpStEj
	 NW1RhRZRMdN/4K/7uU3+DhiMIDxtpnVbYdPDIAzOf2UlWsdVy6af03Hbee0y8jH+Yq
	 M2HzDjpZjVsQKFsFaPTmiJnvBXyyksAwHAkjzMwR3zXdeKUt0YLXKVnQy4qT46D0rm
	 VY5L4inWDW3x1yGp0fghQCxEkv3yRnvZNuSXe50UqVZUVIKVLnJYkIWSlY7aFf6CFP
	 rSHvcHnjz0ntM6PJNl4N0/anmwNkvCDwjd+Oc8PW7ZLh6Kk0PqfcCxybYCEWgH8k1X
	 td9zUXy2v4DEg==
Date: Tue, 14 Oct 2025 21:37:47 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Han Gao <rabenda.cn@gmail.com>, guoren@kernel.org
cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>, 
    palmer@dabbelt.com, conor@kernel.org, paul.walmsley@sifive.com, 
    bjorn@rivosinc.com, eobras@redhat.com, corbet@lwn.net, 
    peterlin@andestech.com, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V2 2/2] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE
 fixup
In-Reply-To: <CAHVXubgrbjHXAPSLjk6uZmUoa52fTYBvutk4q0GFYJPQ0swrGA@mail.gmail.com>
Message-ID: <6c45ed33-d6f8-d385-8b89-9caf2ec18c77@kernel.org>
References: <20250713155321.2064856-1-guoren@kernel.org> <20250713155321.2064856-3-guoren@kernel.org> <1cfdf6c1-a384-43ad-9588-284335d073f7@ghiti.fr> <CAAT7Ki9_Vm0+v9RHpa2w-Bg3agJy2Tp4d6+tcPJ=M7XX3GV-7Q@mail.gmail.com>
 <CAHVXubgrbjHXAPSLjk6uZmUoa52fTYBvutk4q0GFYJPQ0swrGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-522593608-1760499420=:3130946"
Content-ID: <8c856d3f-3e68-86e2-9afb-5e258ef191d3@kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-522593608-1760499420=:3130946
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <dec4a9d7-972e-6220-cb11-4e8c9ec5d42a@kernel.org>

Hello Han Gao, Guo Ren,

Sorry for the delay in responding -

On Tue, Oct 7, 2025 at 11:36 PM Han Gao <rabenda.cn@gmail.com> wrote:

>      This patch is included in the 6.17 merge window but not in the
> 6.18 merge window.
>      Is it possible that the patch was missed?

This was almost sent upstream as part of the v6.18 merge window, but given 
that it adds the ability for architectures to override WRITE_ONCE, I think 
it needs one more attempt at gathering feedback before we do.  I'll send 
that out this week.

thanks for your patience,

- Paul
--8323329-522593608-1760499420=:3130946--

