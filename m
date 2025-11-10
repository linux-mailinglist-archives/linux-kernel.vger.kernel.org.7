Return-Path: <linux-kernel+bounces-894110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ABCC494B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01C544F292C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAD2F3621;
	Mon, 10 Nov 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiRFOmOZ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA02F290B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807466; cv=none; b=HZF7cy3KRjYYVoVQbEuAtyhmPM80J2OkPsMzEEWKtkUtenyjeDE6oDypB0ofRvlLUCdEBeAuNGgZNpgEBSTG7LAsyNvwpFRqZShAqGwoBYViB0D8LRwIBDvrkqMYX7qu7niyP8lGUPDc8OyXHiV4yE+8qFKjRZRSZQlwrzishmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807466; c=relaxed/simple;
	bh=1pRo6FcYmFekXp6UMZ3cZqMsEhMk7Ue52qE3SPSdaiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hv1ygNMgV48wm7NjN3Kjq77O45rGyuY86/RD5WvF8H6bChdyrbMpUy6CVFXBYVU9wrwXTvVThOKvl9PDyeF5lUwKkGeJSpEppv3auWwgwS3lRpQ+NPjoVx6UtPUtu+cxaGdm3IHDsW8fQq3ZRnRDbYWNZSzUKuyO8hzJ+cG9aUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiRFOmOZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aad4823079so3125288b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762807464; x=1763412264; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iKPfFuPx59pn0UpS2AdXRDeAfpJEQ1HphTQyjMZvYAg=;
        b=JiRFOmOZX2Eq+5qgWUjRa2X3kbqiBt5jOO8rZAIrdytPrNh45dVjPnmzxlqhZz76Cy
         ZDrNapc5UCBTMvFwx5a2l1HeXXR1QZv8Azd2YTbQFppeRNbQXGWyeQzBzkF/xrSzMCLM
         fZHbtY7/brz7XKRy+RT21YF6yo/aEuQ7rbw6iwZLAuDRRlE/7eWWbe1Gv3JFXFGzpDb1
         kod0FZd5/1V7jRnWvU7Rv3EPkOEi1SmdVMnzg5231H9yQXDgiPib6UXSr0Z0dQmJF1qP
         V+0F2VdnU9/a+5wal9AmqZkz4JLvhEQwl84L4KoWcP/5VdchsIfK3p52Gmh14O//Hs1Q
         INcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762807464; x=1763412264;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKPfFuPx59pn0UpS2AdXRDeAfpJEQ1HphTQyjMZvYAg=;
        b=ApfhMn2GtdtP9D0UHqwWU/KA+gsnjSx2hQTcITcVS4gHjjDSjjC3V65CFC/6kJp4y8
         9S0mzhxnHwRkPtpbxELcL/0cWjnAMNGZ1GJbbl/eXJdHf7XTukOwBfsoWx8DFBnu/+0c
         KWDOzFenMyriD6rKQDEOFmOz46oYbq10LorcKr2hCOFmEg0oJ0Z2Db2DFv1e2N9ihbOw
         Nf4N0U+iPhV1IPkYoTj/hKRY2Td35Rrsk2zIYLYG0aanqC0g0e56JcKXrOVaPdl+Zf3P
         Z/pRZb9LkaWUBy/o+Ebgjmek21M3xvaTmPmFAfHYjWuH/bYtAPflN+JdFrdPUUALNO00
         25ig==
X-Forwarded-Encrypted: i=1; AJvYcCV/Rdb0Yb6NP6OUKoGoCtxwLESxzMYbCYLnnb6DQkG4q/eIbL6SnUVxZt53c0/JxvRpPmFM2NdnGzHSupo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3WE5wGkft/k+ZghgaNSSWmHch3nfgFQ0gSl7eKCuQdm8JJpS
	ynVzDHzGQSTvbrqEq8qWgF/bSeYNHG8m4iZ809GIhDNgPHzxyWOTOguL1rcmIPPH
X-Gm-Gg: ASbGncvoSIOPfoBVGX/uZVO0A1y3SDyd4iuHlNxzzjfClwaOXChrUiqP6YdLP5WbkPc
	knAx+3URygz7ckFiDFxGOWX1WISq4XdlSK9g/iJheYXq+9KNl4Rc3Qp/sdAemO8/SpqdQYcuBFO
	OYkoAOksMOCra3XWt5tOelev7dUBJFK+Gi/qM8XcUQp4bVTS9STb4H7SlPTKsRyxA4lv5OWTYbg
	u2dytfEsAYu/r88xDxvQtP3F5Ric0DPN5q3eG6cOKm7jfdMAuKgZutNB3V/qXS+hG7bxSZSHccf
	82G10TB6r2Z8q+XeMrp7ca7RnkOSRQP5mUwNd7QwgriJ4jLRQoE3ANbVvl8ZBHOXvP5qfG65Pab
	zVDm1asgmxIK2BXFcCGROG60h4MesScaKAedGOFDcFz5ZAozwECQpBl+06wSKjRZ65RAvNinmOx
	rB/OW3hqrm1EtHNvnSJcCX1YEJ
X-Google-Smtp-Source: AGHT+IGLQ+TKStFopEippXXCOLfymt5XyhUQ0gz+x+HlNHUomSsmKq2g8X5d42p43jRwj51NHHo8YA==
X-Received: by 2002:a17:903:988:b0:297:dde4:8024 with SMTP id d9443c01a7336-297e56622c0mr113277145ad.23.1762807464301;
        Mon, 10 Nov 2025 12:44:24 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:5ff:e0da:7503:b2a7? ([2620:10d:c090:500::7:ecb1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297dfcbe798sm92498915ad.19.2025.11.10.12.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:44:23 -0800 (PST)
Message-ID: <854a2c2ceaa52f1ad26fb803d1ad5668fd3200b3.camel@gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary
 search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, Alexei Starovoitov	
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>,  Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	zhangxiaoqin@xiaomi.com, LKML <linux-kernel@vger.kernel.org>, bpf	
 <bpf@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Song Liu	
 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Chris Mason	 <clm@meta.com>
Date: Mon, 10 Nov 2025 12:44:21 -0800
In-Reply-To: <CAErzpmtViehGv3uLMFwv5bnRJi4HJu=wE6an6S0Gv2up3vncgA@mail.gmail.com>
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
	 <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
	 <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
	 <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
	 <CAADnVQLkS0o+fzh8SckPpdSQ+YZgbBBwsCgeqHk_76pZ+cchXQ@mail.gmail.com>
	 <5a8c765f8e2b4473d9833d468ea43ad8ea7e57b6.camel@gmail.com>
	 <CAADnVQKbgno=yGjshJpo+fwRDMTfXXVPWq0eh7avBj154dCq_g@mail.gmail.com>
	 <6cbeb051a6bebb75032bc724ad10efed5b65cbf7.camel@gmail.com>
	 <CAErzpmtViehGv3uLMFwv5bnRJi4HJu=wE6an6S0Gv2up3vncgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 09:42 +0800, Donglin Peng wrote:

[...]

> [[Resending in plain text format - previous HTML email was rejected]
>=20
> Thanks for the feedback. Based on the previous discussions, I plan
> to implement the following changes in the next version:
>=20
> 1. Modify the btf__permute interface to adopt the ID map approach, as
>     suggested by Andrii.
>=20
> 2. Remove the lazy sort check and move the verification to the BTF
>     parsing phase. This addresses two concerns: potential race conditions
>     with write operations and const-cast issues. The overhead is negligib=
le
>      (approximately 1.4ms for vmlinux BTF).
>=20
> 3. Invoke the btf__permute interface to implement BTF sorting in resolve_=
btfids.
>=20
> I welcome any further suggestions.

Hi Donglin,

I think this summarizes the discussion pretty well.
One thing to notice about (2): if sorting is done by resolve_btfids,
there is no need to check for BTF being sorted in vmlinux BTF.
So, maybe it's a good idea to skip this check for it, as Alexei suggested
(but not for programs BTF).

Thanks,
Eduard.

