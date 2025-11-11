Return-Path: <linux-kernel+bounces-895020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D18C4CBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAA434E8726
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EA42ED168;
	Tue, 11 Nov 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CfTiTPu9"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1222E6CA4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853993; cv=none; b=uJaa7oZVxRBsAjvmGPAt+ZaglnugSbm8bqdwFw3CP+2TOwya+DhK6R5b52vOwanSf1ly0eRW5f25uRSFKjaZpwWSkYcqIi+BhZJ/ESO3gteohCfmsAS2Tiu19H6RQrkmn4y9SWkGRamlkoSHfd/TwE517rrymvfO1C+rhjNaDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853993; c=relaxed/simple;
	bh=0qHk353sMNXNO0DfdJ24OLoqMz+VA+2bTVAiXM7RnOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=filji4bUA57TPLTXTpRgxskaLbNqP3lw9sUJHl9dQlpFntXb3PLf7FzQyjD5e/RFAD0w/HcAb9Sdtg37l2PkXcWhXHqmp5Y3RQRgIP4bSNuRNw5CQeBnpZ5tZd5VBQGBqUwwIcc/eFxw6e/KVr0JcPTQ6hiEjhc3/oPCAne5TIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CfTiTPu9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3437af8444cso2262690a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853991; x=1763458791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x27CBOBuvs19lllL/4Ne+a54Yz+5/uzP3YpUzWY+JnY=;
        b=CfTiTPu9uAzZIje6WtImbQO8ZfKqsg9T7dcF+E59e42zKjW861RFYZUQzZj0+ciUaR
         DLzB9ssxsP5qzGnkqP45MAYLdCNf17TqlYtqDZ3fCjCWgihnJqsDQZDcfRSQ6+rIpJcE
         BXNyyoYBNyJ0GhiNM5eXjjX/a0xrY0ucZj3yFsJb8EOWFYODEQJoexbVMzqRXgU0NDTT
         rL3U4RRH71crF5rl2y3Ut8G3KOsjc3jEjX/yNmFbQ+0QJ5qApluaM4PiA9o9Ioq0oiRX
         pdcmAAU51jTJJyFZw2Ji5Rc08/AvR1L90fAsAmMcGBi/XEeg4cjDJRbT8nhn8iQvAiOC
         bo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853991; x=1763458791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x27CBOBuvs19lllL/4Ne+a54Yz+5/uzP3YpUzWY+JnY=;
        b=EeLbHnrCA1LnWru9c+SNnCxTpQG0ObC1rJhfsyEEKg6u8YXXlW02k0i8boEzcouSG0
         QV1z/JJrstXi7N9iVGAtV5flPZaHSS8wF4o81cPL/4FRX35slWcXmrJhcbjp+vtk1yGc
         mBZ+0DIdmJ8cKVoLK71wLdSY2Qp21Nzv5Qm8iJC4MKuGQzn3rrRR28GzkjEqypVqzhei
         vEClGBr4V9THlJ4B0OL71O1XBYoq9do/HA+wluaXlaj91t+joMdNpLFkcin9vA5tKGiz
         CwSPFhGc+2/iI+uOtrQ7X1Bsw8jBm1sE9vqUAuDumzRGtOxABBMH3Luo+vztGZDkaFNZ
         icuw==
X-Forwarded-Encrypted: i=1; AJvYcCVGm6qXhFSJx7DBNh47eNiVMcZtYL8LSmbvsiKejdDFTID63qzAtI5rANqDKxf9hc8SNQ3BZr8AZqWRgPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxycTvbdItBEtpV7mD4GjGnu8WPm1EXQZXELSL7w3DFwkCElaP6
	m11n1kWjl9IQs73OnpIPi/zM0FqC2E8W2OK2539P8SMjhU5rb809g6890h3Getf3kK6nfoRd7bj
	DabWX3R/oH33rWU0+69dI9mH7DmbxLOppqqr9KoeV
X-Gm-Gg: ASbGnctTdALCBc3+DoRcsirP3OBvBhSUwg5zp3e9DXiL3bceLwBSMO9Co3oTMSoI5GT
	6wt6MjrWpGY7xKn7zR6lqdB+n3Mn8XBbUKcrd7Jgz4AGOyTZ1OfvXnpRII7uwmQ6vcjRs0JcYmO
	27ZHkcaQsqsidD+rQFwVoQHvD7Evhylqk/E+rx1u0AxBntzqmxI2qh5VnTmP1Xf9KhLiGyCNI6i
	MSJq9tW1ZDIaoIfRC7myhcrsmmtBlVD5M0vE9tw2C1l6lQpmTcsUISbJwngsMqhIKwFCziBj0u3
	P263M4q3EUzQpRJ0vm44POqQb1D4owpgqYrh
X-Google-Smtp-Source: AGHT+IHbYtcp4TEm3YWuggGsZDtmzQmO+Esj4ot5UyBq5O3ykfRy1t7VIIRByVPx+YeUvhQm6/mmmHJjCQ5y0jFctOY=
X-Received: by 2002:a17:90b:2f8b:b0:340:ad5e:c9 with SMTP id
 98e67ed59e1d1-3436cb9f0a4mr17438597a91.16.1762853990547; Tue, 11 Nov 2025
 01:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <ab71a0af700c8b83b51a7174fb6fd297e9b5f1ee.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <ab71a0af700c8b83b51a7174fb6fd297e9b5f1ee.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 11 Nov 2025 10:39:12 +0100
X-Gm-Features: AWmQ_bn-DpseVZlfA_JkC1KeMe_i9gWzENoYdJOcpoJ15BxyTxVZhbSiKbweC94
Message-ID: <CAG_fn=XyQ5Mc_ZvsibN4K0r70xfDAkhPqUJgtojVRcgTt-q0WQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/18] kasan: sw_tags: Use arithmetic shift for shadow computation
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, 
	kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, 
	ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, 
	baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, 
	wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, 
	fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, 
	ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	brgerst@gmail.com, elver@google.com, pankaj.gupta@amd.com, 
	mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, 
	thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, 
	jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, 
	mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, 
	vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com, 
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, 
	ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, 
	maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, 
	rppt@kernel.org, will@kernel.org, luto@kernel.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b00849ea8ffd..952ade776e51 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -61,8 +61,14 @@ int kasan_populate_early_shadow(const void *shadow_start,
>  #ifndef kasan_mem_to_shadow
>  static inline void *kasan_mem_to_shadow(const void *addr)
>  {
> -       return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
> -               + KASAN_SHADOW_OFFSET;
> +       void *scaled;
> +
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               scaled = (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT);
> +       else
> +               scaled = (void *)((long)addr >> KASAN_SHADOW_SCALE_SHIFT);
> +
> +       return KASAN_SHADOW_OFFSET + scaled;
>  }
>  #endif

As Marco pointed out, this part is reverted in Patch 17. Any reason to do that?

