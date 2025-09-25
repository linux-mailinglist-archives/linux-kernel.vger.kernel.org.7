Return-Path: <linux-kernel+bounces-831545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01440B9CF96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB81421373
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8934C2DCF6F;
	Thu, 25 Sep 2025 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAV2cPN0"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955BC14A4F9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758762360; cv=none; b=CRzT3O0s3NMrSBKNxX8otRsSfclAjT1dXZWusM3oHlQRyZvOEdC0Bks6E6YjrZrymb6Ub17irN0//MHILcMtCZdny9HiHsatn+jJ18N//V3k/QUlxOIYYa/rb+D+nMV0jslWaF/jtpRcGBIMNB7S6h7OpB5ATFw3wBENjeA3/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758762360; c=relaxed/simple;
	bh=QtTNRMNsCZXoPgwJxEVdzGgxg8j9AnQphmi2AsF15T0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8ywY0nMtNpt/fa6Bb7DCBHO+tD0hF9IixSCSwig51xFbrmaBR7OKMUQEpiutynCYqN7tIwoTB4mh7ZPDfstx6ExrV4yWvzPg97pbSAKufmEb3DMtqgeJ64A4xoiObDQdHiiFxARDMDZnNxbuIUsK6kX5ALGhoUD8AkSTEFciRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAV2cPN0; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5565f0488bso302083a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758762359; x=1759367159; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQt75DdC8qDrtyjja2Oov+kDMmzEtd4kIyWgE1cwVHk=;
        b=dAV2cPN0OqdwvgjQSYURQOgTMkaRxCWIgeeDWW2VpXyBDNCh00+5BscRoMoeqaDk+I
         63bemuscX+Gvdhi9KklvLwtO4gIAOf6zI8RaInjV7VUEYS/CY73W9kt6LgRc1xvOP6rm
         U9LDCXC+HCAqANPzvdWQwrh6JSQ6wfOXml+L7rDVDN346WiUVb38VO5KyLo/GE9eSnRs
         M76fOW1kugq0J8/9nVuJ7UtzdhP3ofYEz58Q4x6EvaU+eZhMEEct5zMKBOBzO4HzQz9Q
         d1sRpL1/xuB+O5acvXT8CdNy4eSjAWqhp3braJHtYNOCwMkVazk5cQQL+Q3JRgeS7Bd0
         kb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758762359; x=1759367159;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQt75DdC8qDrtyjja2Oov+kDMmzEtd4kIyWgE1cwVHk=;
        b=RtPbGKg3oCqBNhS6b1WhMoZdRYgaA+ZTwzvT+jQXoOBeCiLkG5YxtifBMw+tjvEzSU
         WG/YLkYq+Gnf/KtY2dCOzLXw6V/+lYVVHnTAdjaGcg4SEwdIpUyaCCtjuFL8+Pk5frwU
         b6fGmFe+lXeIVDziPJMbIv3KqcVdicFxcTWrPdM2G7+4o7sHBDUiFGWofJvw303AL1Bk
         MppcbJng1EdL2A4ml5oTBh6RGOMe9AGHBTxcwjKTomULGCT+ER/o9BGNwpzqiBfcyKgG
         4zQYR81HCpTk+k7a0ckroK/5x9W9BGTgHgbs0VfPkFyw1LNonXsZ5vfMjlx6JZM4YpAj
         PtCw==
X-Forwarded-Encrypted: i=1; AJvYcCXmmYmH1JcKMBha2eRLqewsi/FqcABXTaq+dGdvpQSMVhV6kJjt83sO83oE+rchO8Ap3i7YMwct8AF9U4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwgHvQvPAuAtCEGCliQ3rLG2FRF/fi4FrXd+XkGXf7oH+GU7c
	XP5xRNtip22vo/wGv7cIudeowrzCZxjaD9e1Qn/qPkGwOOCQ2h2WvTP4
X-Gm-Gg: ASbGncvbrJn0WwJ6Q7hvW6+JYx37GhT7tkWSDbPamxLLl7GOGYi++7+402cg2/AVb/5
	H+S3c63nQEoiv3IvMFoyivwVaEXTExIkeEtLRQLK0Av3BIRJZX5YfZU5zL9WxJPbtbCss7gqMfz
	yjwsV1caGJLndcxdgnLzACPBV9qmvpyCJzsrUnSabhmguvdlr2+58FNHE1Ks+Dc9smv2c0s44KZ
	d96Pa9igZeF84dfxBCurmICC10tQrsnZyRAfB6eTgQs5z4/luiPxvsDSnw+NOXzDditPoM5iJcy
	+Yo68ehugQjl+m9kCnhMImtQzIMGpktpn/+VjQiyy/luI653eAo8MdaU3CE/4/U8zvaRI29MUs5
	U/fxwd2EMCsHVxCefZeLIsl7Tt8fNnMEc3b67LltS+9i6VrROvR6LnkMWV+kP+JbzOjjehwB83R
	g3dhe37kvZuPPOMMf2+LmfGCULFw==
X-Google-Smtp-Source: AGHT+IGwHElmVODhLjzcGQwYiLLF8PustJQtiHPJXl154Q9y4nWgofjfbBNw4V3dkvm+lgwYi65hdg==
X-Received: by 2002:a17:902:f541:b0:248:e3fb:4dc8 with SMTP id d9443c01a7336-27ed4a7eabdmr16878415ad.39.1758762358734;
        Wed, 24 Sep 2025 18:05:58 -0700 (PDT)
Received: from mars.local.gmail.com (p958197-ipxg03701okidate.aomori.ocn.ne.jp. [180.22.82.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3ac4sm6088475ad.5.2025.09.24.18.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:05:58 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:05:53 +0900
Message-ID: <m2plbf734e.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: w@1wt.eu
Cc: johannes@sipsolutions.net,
	hch@infradead.org,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org,
	linux@weissschuh.net,
	linux-kselftest@vger.kernel.org,
	acme@redhat.com,
	linux-kernel@vger.kernel.org,
	benjamin.berg@intel.com
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
In-Reply-To: <20250924033217.GA9039@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	<aM15eChUObXfxLzs@infradead.org>
	<4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
	<m2y0q47mbs.wl-thehajime@gmail.com>
	<20250924033217.GA9039@1wt.eu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello Willy,

On Wed, 24 Sep 2025 12:32:17 +0900,
Willy Tarreau wrote:

> > just curious
> > 
> > - are those issues not happening in other libc implementation ? (e.g.,
> >   musl-libc)
> > - same question to nolibc: is there any possibility that nolibc will
> >   evolve as glibc does, and this evolution introduces the UML issues ?
> 
> Nolibc focuses on early boot programs. That does not mean it will never
> evolve towrards more generic usage but this remains unlikely, and in any
> case there's the goal will remain not to degrade the experience on the
> original target (early boot). That doesn't mean there will never be any
> breakage but we're doing our best to keep things in a clean and workable
> state. Regarding threads, it seems unlikely that they'll arrive any time
> soon. But if they did, assuming UML would by then be a long established
> user, we'd certainly find a solution together (even via build-time
> defines if needed).

thanks for the detail background of nolibc.
I understand nolibc will evolve with the carefully considering the
issues we faced with glibc.

> Hoping this answers your question.

definitely, thanks again.

-- Hajime

