Return-Path: <linux-kernel+bounces-879152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2036C2264B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57013401BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA9B29C33F;
	Thu, 30 Oct 2025 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LThl9Pbr"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C71C84A2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858999; cv=none; b=SXsNtIxWuhqCp8baWNzGnVaek+6IpP4sDxsv53o7ktLWTYKBKuwn6KuTMAsyR3J3hmoQyQKc/4dhrr4EDEPBh0/Ub+j7iRGTONLSxF3MD0Md5CIRYg1v2y7ZaIv1G9shvrMDZ7q5gHi/oagsUpaBgq3NHvGO7FqdTLPXCpApuqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858999; c=relaxed/simple;
	bh=wbc8GWEN44VpU76HtfVO0TmGiof5cWv4oS+Oz0cnAN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn0tRM9iD5bvln7oDNGR8MkzKUEmc+njq5Z5immLY9hCaIB98iJMu2v7YeXqLBQJA7tdwrXcBxVyZgb6sYJ+X69rVzN2y8tDCcKWyNJXxQzAWs9hnaZi1V18hthlMQWA55MTbdPZL85m2SW4Bunz1FLIWfHObtT25HTu93yzehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LThl9Pbr; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-431da4fa224so12880935ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761858996; x=1762463796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n046el6sn/MYU05rldbKheOWhX/l2k6l2dudBMXzrMQ=;
        b=LThl9PbrgmuLP8U1jS1l/3MeymFaDjPZu9y6S+dIoKPKhyf6ly2H4gYOBy0ngDowsJ
         zXzt4pVmiffHV+durdNT4elmol8DmUt2rTCCfOPPkFWltM9fPszXh/GNgJOU2dR99Dxw
         rYyn9KuIv/AQPwYYQ+SAuHB2gnOjuyTxrPrpvlHhPxvFCDf0yheER6NRN8d2q3W/PgBp
         ApQ38kyObKJl9ozQGKj4DjUk0GlUFnJqFzeSKzu4cmKidV+zEtqIcTol0hRqTa7MjrGg
         RSozG824Gv+SawO4RXJYWnDxnmvHGcZk1/LWUVQwKJV+6SEwvT2MrsTVn6sIM7c/XpEv
         HEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761858996; x=1762463796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n046el6sn/MYU05rldbKheOWhX/l2k6l2dudBMXzrMQ=;
        b=kK6yfJk2r6sJpZx4diUVJ7Vw32JwB6G+dMki2tjB0pSP4PIHMY1GPonBYdqnBU3C6C
         VgubsJHUWWGVmg7zyFzvQOEF6Dk4PKQGoXDrmJTUVPpTBSeP7brqwrrGPnu9OTePgXHW
         eAkDYiHINvlCNcVF6teYP/P3yKvyrF+bgYd0vmERhcB+8WJLo1TqN22AcxVtqabMtijD
         6ziNOHj8gayUjSwvMGwrohvSTAuaIE8ofK+QSF7ylLTB90MAkfR63/b6uzo96JILmyAN
         kzeKOFfvIcvv/Ca6OPyaKd6ye6zPH3H8i7KFImIoRJR5eclPxLulfil90IAccbJmHmsg
         BcYA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Ncc/e7yg41xNEkw602nyMi+Vt3JPAmVx+KUCWGIBtDgHYmTf4tGcR6G6P+PJfZUquOpBNIHE026umQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1m4ZAIkRA9JsmwZibFbUZIXK0y8RBAqq0cEvy0J1+OL8EsCM
	yYtNm2F2jdpvmknNv46bwFj65ng79d59QauxoI44V1mufRlPI4+j7w2skOeZlUyS/Rw=
X-Gm-Gg: ASbGnct2tgTWY+CiII8flYm+NwlhW88v/MXXptzFK8eP5Rb+1CVMNVI9cOA8woOHSeG
	e9IYg9aZyVJaEbKt3nMYWULXLBAkSNjU4c3EpKUH5N1Y+Bqq+lLZUp0fF9JLUDDSjprwknfVvAv
	ZMF4kQ0O9QF+143iUi5Ew91Ghfk1oDkaFSo3tN5xPj3LzQQ3eCdlp0T79Pyltbfs2YDjNxeOSR4
	C7267zaVxNTHK94XTZ4gLLtxAQHWBBVHK3AyL7H07J4qx355wryK9vIig+mVLRI3voLLW3X9Qql
	5+zSO4CxBbrnfz7wTmWvxxeni4FuNhwWAb7j0rJaAIG46ZvcRtfo42zQJvDQG0NNE2TiKCymlb9
	fmYXbIVSL/vHGrCxQgY7E8IfjxgyDJYsIz6ibnGsuNbe5/pSEDjG7w+SpHygvaW1xNtNVkBJL2n
	tGPg==
X-Google-Smtp-Source: AGHT+IGcDmB7cMvg4ddm9ByxIP9HsB/n5kBYe0Lh8poaDBazZPyPmATszhVqnQa6SFc0vrwo+UWsdw==
X-Received: by 2002:a92:ca46:0:b0:430:a183:7b with SMTP id e9e14a558f8ab-4330d12268emr20926665ab.3.1761858996489;
        Thu, 30 Oct 2025 14:16:36 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea9e38418sm7130598173.61.2025.10.30.14.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:16:35 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:16:35 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: alex@ghiti.fr, alexghiti@rivosinc.com, aou@eecs.berkeley.edu, 
	cleger@rivosinc.com, evan@rivosinc.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, pjw@kernel.org, samuel.holland@sifive.com, 
	shuah@kernel.org, zhangyin2018@iscas.ac.cn, zihongyao@outlook.com
Subject: Re: [PATCH v3 2/2] selftests/riscv: Add Zicbop prefetch test
Message-ID: <20251030-3c0cafb066281de4dacd4000@orel>
References: <20251021-01a9b77e3d88543581f1a7fb@orel>
 <20251023154841.36007-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251023154841.36007-1-zihong.plct@isrc.iscas.ac.cn>

On Thu, Oct 23, 2025 at 11:48:18PM +0800, Yao Zihong wrote:
> > Undesired reformatting
> My bad. It will be fixed in the next version.
> 
> > Should we just unconditionally register handlers for SIGSEGV and SIGBUS?
> I think it depends on what the flags --sig{segv,ill,bus} are intended to mean:
> 
>   a) We intend to handle these faults that might be raised inside the test
>      (i.e., catch and convert them into pass/fail results without crashing the
>      test binary, rather than letting something else handle them externally).
>   b) We expect these signals to be raised as part of the test scenario and
>      handle them within the test program accordingly.
> 
> I'm not sure if (a) is appropriate, since it might mess up someone’s CI
> or other automation setups.

The intention of --sigill is to tell the test that a SIGILL is expected
and tests should be run to ensure they are raised. We should probably
allow that expectation to be extension specific though, i.e. have both a
--zicbom-raises-sigill and a --zicboz-raises-sigill

> 
> If we’re going with (b), then registering handlers for SIGSEGV and SIGBUS
> based on flags would be inconsistent with that semantics, since prefetch.*
> should never legitimately raise them. In that case, this design probably
> doesn’t make sense. Would it also make sense to rename the '--sigill' flag
> to make this clearer?

Since SIGSEGV and SIGBUS are never expected, then we could always handle
those in order to report failures, but we should narrow the time the
handlers are registered to be just around the use of instructions under
test.

Thanks,
drew

