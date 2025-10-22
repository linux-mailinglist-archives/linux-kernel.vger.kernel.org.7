Return-Path: <linux-kernel+bounces-863927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C52BF984A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74273344FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD92818B0F;
	Wed, 22 Oct 2025 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLmSbWFT"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60F2F29
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094127; cv=none; b=WHO+WAGoA3/3qNS34scE3UYwfDCqP4O4B8h5YlqpY1YHiSMOp3fgkOl5XAhSDrK6QnJiClATCKQEOAs0V9fCYz/QTP4r6Ue3ZLGB8seu2lfOoOFEArEK3NDwCwmg92MR58lWM/ZS4pWX+1/rJCzyBcQTGoX58EI4IljZo+Mk/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094127; c=relaxed/simple;
	bh=VVJou1iPzbAXQP9htPxF+ZSyy1ELgBtuWy2qmtheHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9QHZCD+KyE8ny2CiZAuLoci31UsWlfHtbyG6k0kgrPG5WxaKUUOPml85TIk/KSMNH1RFBInk+Z35NHX/9zeIDxCMihuRos7415TnDMCsYSvf1oS3x3dR63CrT56OntLuIxNr/wDHhuRsw5J9I0HQnBK/bEY71Qz3r7N4tWZvFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLmSbWFT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f5d497692so7711640b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761094125; x=1761698925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpwLRNrV83QpBzzvqKFmuh/MORhamr8seHZpCFbDI/k=;
        b=HLmSbWFT8m12QI4GjHjoXpdjBSz57Asv40Flqge5XmO0S4lyV1PYp5C22YLkv0mzqH
         WoeeB6ZIdqpClme/jEV+L+BkGyFP+ywK/5HzVQubZRgpwCd12wIlDnaOrbyR5o0qsLWH
         EJiqYUsXfaV8MHi7fg92FY2FkBIiIWABmnulYSYSMBPUasyFF+OLvANI3pIjUE3SgMbj
         F21uZnP0yathmiBcdH6bx/DFP41lRhRiSvyKHFSMKDQjj778s1D93zyXvhFlHdcAdV6l
         lXk26BomyN1pEYCxnhga+oja5IJkbqb8Vd+jLKQ9g9PuVkrlVVM3V3O6BxK16lX8Z5In
         ty7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094125; x=1761698925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpwLRNrV83QpBzzvqKFmuh/MORhamr8seHZpCFbDI/k=;
        b=lH7jcdxVyGTMITTOop4Wwpih+8MOQ0ic97cK1LjD2BI2/Hl8/lk6etxsAgiwhaXsDd
         YjH88frgpktF9RonByLOyzDeh80I6Htwv9OLiwoUVvNiWc8UQmrpU9XR+eT7fOJFtxoz
         UZ20HgIEVr4DnPHLi4WPEYowGjdC49+bCKaOxSn+YL5OyfLfMw1t1idKbYLyJ8dm0+wk
         OKawC4+culVM8u2IKZ5NtWkkbWOCxB5ALXvZJssI3P+Kht1KBSAhxB1+FUqODqKf2mv0
         7OVGSWi85YQSrYjNIk/MQlxuC+IOI0qkVqzGQ1KdnehKS8LnSA7zDAaqxEUCePJyB6RT
         hC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnD6mR0pvxoNE0CalsjHxPYau9sLKroCWIkGfoUJrjeUj8OZl/BnDOdR7zYfCS0eLDbeJQrWnHy4Mk2oU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OPyvyu7MgRlX8LsPTIo+2Pwxq8onN56STkmDnO33FzbRi04E
	xQRNEzaxxrXLiTKbg7i5UDkzJ8GGcHPmw39odOueTYP6URqPsrHRD9Th
X-Gm-Gg: ASbGncuGOFoFFoHbuIRzb64iWdE+Tvhylsj8BflXRxo8GFGrwDDQywd4qtp5Iof4uiW
	HIjNuXefo/sbAM1kwRAPyLCduiWjRE5iKkYSkAAx/Qr4Ou7ZdmhEdZof+atNW2DbkYD7dfpm4Ou
	V8kBwK0VLmWPZ1n1njYxCtpAd0cYtqQv9ZaZdhC5D02hqWBuuOSZvsWg+wdmC4OmnDcJGnHCkJB
	ae9iv3bYfMTig1TnNyfgbbhgCWsLClcn/2aneoCCj7JIyyuAhq1on5dURHpM6ocwd4eHHH7eepV
	BUPXQQDNo/u8i9bTFTh4TG5JB3GTZebkP7VIJOdkWlpWYnCmZIllPUA7KI1tDYeUIcYA2qOQTzL
	5csvogPNwMNOM7MdA6GN8jqpaTbwUDZQ78rfO7TSqh5SdqGDqwgN+YlvB9FkDRu99My/YYR4Ire
	k=
X-Google-Smtp-Source: AGHT+IF24ChetCW9CoKabWAzNvhbTnSK3MzmoX44gomg+ux4PGDg+A4t+y/Pa4mmCa5vznWef7GAIQ==
X-Received: by 2002:a05:6a20:958f:b0:334:8335:9d87 with SMTP id adf61e73a8af0-334a856e41amr26332793637.19.1761094124970;
        Tue, 21 Oct 2025 17:48:44 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b69e68sm11229683a12.36.2025.10.21.17.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:48:44 -0700 (PDT)
Date: Wed, 22 Oct 2025 08:47:51 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>, 
	Inochi Amaoto <inochiama@gmail.com>, Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH 0/2] riscv: tests: Make RISCV_KPROBES_KUNIT tristate
Message-ID: <umhjzrkzfe75mbtjeo7bsbziprvxicxrionbmumynhqrtut6hf@wt7hwbhi6cac>
References: <20251020-riscv-kunit-kconfig-fix-6-18-v1-0-d773b5d5ce48@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-riscv-kunit-kconfig-fix-6-18-v1-0-d773b5d5ce48@iscas.ac.cn>

On Mon, Oct 20, 2025 at 08:23:54PM +0800, Vivian Wang wrote:
> Fix an allmodconfig warning on v6.18-rc1:
> 
>     WARNING: 3 bad relocations
>     ffffffff81e24118 R_RISCV_64        kunit_unary_assert_format
>     ffffffff81e24a60 R_RISCV_64        kunit_binary_assert_format
>     ffffffff81e269d0 R_RISCV_JUMP_SLOT  __kunit_do_failed_assertion
> 
> While we're at it, rename the test to remove the word "test", in order
> to conform to the style guide.
> 
> ---
> Vivian Wang (2):
>       riscv: tests: Rename kprobes_test_riscv to kprobes_riscv
>       riscv: tests: Make RISCV_KPROBES_KUNIT tristate
> 
>  arch/riscv/kernel/tests/Kconfig.debug          | 2 +-
>  arch/riscv/kernel/tests/kprobes/Makefile       | 4 +++-
>  arch/riscv/kernel/tests/kprobes/test-kprobes.c | 5 ++++-
>  3 files changed, 8 insertions(+), 3 deletions(-)
> ---
> base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
> change-id: 20251020-riscv-kunit-kconfig-fix-6-18-01fc6eba6613
> 
> Best regards,
> -- 
> Vivian "dramforever" Wang
> 

Tested with allmodconfig

Tested-by: Inochi Amaoto <inochiama@gmail.com>

