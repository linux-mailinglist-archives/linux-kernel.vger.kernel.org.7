Return-Path: <linux-kernel+bounces-861909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3210BF3F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A11C3B3159
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8842F49FD;
	Mon, 20 Oct 2025 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uOpR2q4Q"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CDF2F1FE4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001260; cv=none; b=NEjUhmF1rRmzoeT1Jf5WJ/Hh95mj1j5Cxr3beV/EgvMlCM/2WegjVcdYZ8b75dazRocE+Y/t1ZXzIRE68ZGElL1o5pG61t6QsMDEZgNZS/bfmyk3EGbYgRoXQln2ZOFMFT+XmllIqFE7bxH8XBIJXXyaJO78lfiVpgWOL7RiScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001260; c=relaxed/simple;
	bh=MMIhDjeFZTVW06BO4C5sNb1AQjnc/2P+QYmht/b71sI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GE8W/wUvAjQ+1J8BS1zrRW936uEdtUET7wg5H71flxP13ZucJoQdGVmSzchrtfV60pMl/e7XcYkE/NjXDbfBN4wflWlb1T6RpSqpyDLeRYQufp5gjaCzMLoyT8IL5gzrD//rMh7KWeIwb9aF6cKxKOMMaj7gnlcBHMLZjVUro7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uOpR2q4Q; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47106720618so30596675e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761001257; x=1761606057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+YTl5MaFNDPh2LQODMBbgsO+rt0d2j5pgrcEowQ9SQ=;
        b=uOpR2q4QG85vO2esKws9oeFb8lSeEXlUalC5+IRJgCJmGfDdNmSH8So1WNDPw7cr/U
         xzBPiLTWtuop9NYgtj51XnOgC3KnmktSkdmt4YpZnPba0fV+nBJ3ihQr6SBGmfYWakzb
         QWvbc0ck/lwe8IXaep2P4dbFY3Ipthttx1aI+NAHnW3a3yZLFTTuRX+7Hy0K6Bzh5JJl
         BLS/cwAnyTK0hh5qi6L90j1T7twQ+1N8Judit1Acs20h1IRFEeOwgCj6bpl0SF2g74W2
         G3c2c8uCjM0dmaFLiHWdfUBQWMuZ/lQyWAp9trha6i0m4EROc+kumqlct2pTNjJPgp7s
         BOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761001257; x=1761606057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+YTl5MaFNDPh2LQODMBbgsO+rt0d2j5pgrcEowQ9SQ=;
        b=hiIC+cnLYkM3QnOPfIcqp+bbZfrSXTWcmbi587ZEu7B59229zBHjZSh1r2VIRLpggI
         TDPz8xuVtCqZB50aQSyvYCqzWpf8UhXL24dzzSH+vy+NiOeMFQsKf2oHCWlH3qqbrL0W
         GtCHYyzjQjRBnpR7jDZanpLEQrsJkjeXwS56PTKg8HJ6tX5uBFUSiCeyfdAF1Li2liDz
         tgZVBHjwE47iqDlmkjuGMtL50pSDNAl2zC3bXjH5T4pqajjqOH2DkILz/p0CYmNgSrVO
         SmzelNl6MxnIAysvKS2Y1ocnadIvv8xVS77Hdq/IvarXvNh/J/KQJJ1l+CRAFT8D+lIB
         a8rw==
X-Forwarded-Encrypted: i=1; AJvYcCV9ijTlgj6hz6woIyaZFuSe1CLMIc8c8D1tEbq8tDtQIUsmcZ+NAYDr5niOREq4dwuvBxxicxDkSpENrXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuH/RcVZms4A9H2wzNYLif2sYmfdVmF5x4Fu5lkrpZs1mtcPq0
	F3+JdO8HD9OleNM1x9KnbRO5aPmmxE16iVUEXldkoCvJqEi0OmgdkjOiBHyy264maQXlAVy6Q3V
	nckKknXIDcXsudLiZTg==
X-Google-Smtp-Source: AGHT+IFXOZk4fKNLEcQ194UEEQFUbHuH0Kfa7GML2Cmd8kN3Tsh2FLTTo5Kx6voF7xttPbOLL27F2j29/4j8wOo=
X-Received: from wmbjx13.prod.google.com ([2002:a05:600c:578d:b0:46e:5611:ee71])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1884:b0:3ec:ce37:3a6d with SMTP id ffacd0b85a97d-42704dc9a96mr11386255f8f.47.1761001257442;
 Mon, 20 Oct 2025 16:00:57 -0700 (PDT)
Date: Mon, 20 Oct 2025 23:00:56 +0000
In-Reply-To: <202510141538.VZqnRzHh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202510141538.VZqnRzHh-lkp@intel.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251020230056.726931-1-sidnayyar@google.com>
Subject: [PATCH v2 10/10] module loader: enforce symbol import protection
From: Siddharth Nayyar <sidnayyar@google.com>
To: lkp@intel.com
Cc: arnd@arndb.de, gprocida@google.com, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, llvm@lists.linux.dev, maennich@google.com, 
	mcgrof@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	oe-kbuild-all@lists.linux.dev, petr.pavlu@suse.com, samitolvanen@google.com, 
	sidnayyar@google.com
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 14, 2025 at 8:36AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Siddharth,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on arnd-asm-generic/master]
> [also build test ERROR on soc/for-next linus/master v6.18-rc1 next-20251013]
> [cannot apply to mcgrof/modules-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Nayyar/define-kernel-symbol-flags/20251014-005305
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> patch link:    https://lore.kernel.org/r/20251013153918.2206045-11-sidnayyar%40google.com
> patch subject: [PATCH v2 10/10] module loader: enforce symbol import protection
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251014/202510141538.VZqnRzHh-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251014/202510141538.VZqnRzHh-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510141538.VZqnRzHh-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> kernel/module/main.c:1271:32: error: no member named 'sig_ok' in 'struct module'
>     1271 |         if (fsa.is_protected && !mod->sig_ok) {
>          |                                  ~~~  ^
>    1 error generated.

'sig_ok' is only defined when CONFIG_MODULE_SIG is set. I will wrap this
statement in '#ifdef CONFIG_MODULE_SIG' in a follow-up patch.

Regards,
Siddharth Nayyar

