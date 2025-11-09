Return-Path: <linux-kernel+bounces-892056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0171C4435B
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 18:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C67E1882253
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765AD304BC1;
	Sun,  9 Nov 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVNrL4X5"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98B302163
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708067; cv=none; b=eg3hh1E54rZaM20WQ1JpMAuyp2YRxEkKhwBrMJHWmjI3oij8uGuTpY95lqdiqRvnTfKd4WPaLL1iolCRl5fbVkcQfeFOkatDXwcmF3cn8EoWgAQLVXuq1cDTfD+lTzpTix18LqxS12KEsBCQzOoacpYb0A6BPX4E74f4eFi44lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708067; c=relaxed/simple;
	bh=3rqCb9e2fqvIRBJhRM5QwHp9ZvBo/t44Ip10A8761Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwNBdMtejucauEQU6n3sqPisRHSkzY96l2YnE1dFYFr3IEm29fw56gvifPmx9Frnz1/F5JacyFomaEnfe6VzmdHCfoHqsMgzhhWBXN6vOW9S70SkUYeKqg+Px1ksZGP2VHMkk6/a0waSfGw9hS+UZeCCm5a83WqT0czqHsee3tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVNrL4X5; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ba2450aba80so1231860a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 09:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762708066; x=1763312866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1FNiL4lN8CLTL7WaZG1viN8SOw0TC2lym8ciARU3xw=;
        b=aVNrL4X5pm4oodCbFh3vXpVyPSHbmP2ob9O7j7+2vfmxmsC8ilNlg91DaHPM/vksKA
         I+k2tH0lN8iXD0wzxdiCqc62xt4RnX56P7IokbgFgoSKtMB7IpWAhqN9PnyKj3/bKjPh
         qUXO7i4qqhqu0MwhH0IOsaGSY1SCOi6kve45dwQB1fYpfIcOibqgB2fsRRGMWJadEk06
         OzCDq4BxmBc3NeMfnRseP7ELcd/steV/8cLh62xGo6YcQSoV9kprXO0LcsFSGCpzE0rw
         f6ahtn4eiQ5+lE7Kot76RvCtX6K8/zg88hPnz0rPat6Oy1w+4r4ORy0GWSS57+QStAcg
         yocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762708066; x=1763312866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1FNiL4lN8CLTL7WaZG1viN8SOw0TC2lym8ciARU3xw=;
        b=X/CtZXAFScG27f3hXh8oA+Cbmiaq2JMXnB7+/fIZAVOsE0PLK+fw9MykidgMJVsHEi
         fhdv8PgfstCju16Ajo/w7JvCkPm6K9yBDM2FXgrcbsLrExq995JFHW0/QkaPhd3Bu7+u
         zynUN0U7bYHVBOIev1X57t0IvCbCBCCVjHdqxnlZVrqvDO5hZnJhWUUTSuresOvR/J23
         fn1IDDSamzSyZn0Gx6bGQ5j2apzi95Cv5rPh3R2TLFbhU/fOxviy2mUEelfmZzAQ+hVU
         qgun+VL9ShZTR1/Yd8bOtveqUFKnTHz0bgXzyKIIEWo8q5WrY4DJ2K6vbla4YPVjSjSe
         dYTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6SVI8xBVCQooUmurkSbN2DLRaihuNugU+q04MXXEchIuPiQFXouljgG3ByjJrzxihxp+SLueGLuIhxiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzmFL8rNZQNEjXyy2jfySBw697uKl8lf1whabsIdZtgzMcQjq
	fGDoN3+xq5CytI2lpkXm9OCwqEMUv7TsHl9eFgrXccQKLax8KbIaH0Ix
X-Gm-Gg: ASbGncsJn1iRsvpYc40yYwfpeHpke87wZGnCoM8tIWwNK4Tr1kMqhnmEc9yXB73EIcn
	YuNsf6sao5MZN5ROX54Ysx10GFp+C4NMMbpRHZwGajREataUn3Ta6qgAsDMx03nzFgGDIon+aqv
	J+WBIhigl2wd27PD4IVIFjSzGA6v1OHPYf91Ic7TcpLjJ0Yj43ddwQlHGUXzf3P+zuWh7c4nTbA
	0qejLP3ep/zwNfmd1kB562azwZqraFVj8Sj7hgFwz5onC6re4xNW3D8+MIUQe8JErfdeTdF5wAa
	BdXGFwEE0VX14HuHW95Tw+wJ9S1AY5kEe1toS7A5lcN4P86G7grs0TvTPYEgPf3vC/sozvUWslu
	2g+Nr0HQRd6rT6zPWyv1oTU2c6rFiNJ20SeNMzLMzQiR2HkNO4clZcdY2KlJZv86yB92kc76od5
	Y96LvW9zn51QdGRcb3qNKHviJ10E3m+pF/Yat5DjZSzzY=
X-Google-Smtp-Source: AGHT+IGaUkeabb++qUmC+bOuTrL5CUbZWgq2rW9tYf42/ySSJ2DpLXTzPR16+AhOmoYX8uvG88oLjA==
X-Received: by 2002:a17:903:fad:b0:295:9b9a:6a7f with SMTP id d9443c01a7336-297e571290cmr71731095ad.49.1762708065697;
        Sun, 09 Nov 2025 09:07:45 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c841sm120391455ad.72.2025.11.09.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 09:07:44 -0800 (PST)
Date: Sun, 9 Nov 2025 09:07:42 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: Remove unnecessary __GFP_HIGHMEM in
 __p*d_alloc_one_*()
Message-ID: <aRDKXmwJeosbvU6N@fedora>
References: <20251109021817.346181-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109021817.346181-1-chenhuacai@loongson.cn>

On Sun, Nov 09, 2025 at 10:18:17AM +0800, Huacai Chen wrote:
> __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> as follows:
> 
>  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
>  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
> 
> There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> explicitly.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

