Return-Path: <linux-kernel+bounces-748500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD634B141EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C833A27E4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF7275AFF;
	Mon, 28 Jul 2025 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2vvpqoWH"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9D221554
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726902; cv=none; b=NqwqOcCe1ikdlJZGpZ5jMexcZt/udVI67V5wf7ceunWTR79DNKAxizsHs73G1pQi6dwZXtvjHoU+s9t0VeMePxELTozLhe0D2YiNvk1phuQYhERlXtAbmypCKwAl6ZQJpavHBBc0XFmRVQrYJW0vLukIvdRM2WC01xpHyHbO+7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726902; c=relaxed/simple;
	bh=dG9bHeLM1xk//tApPMXIJ61OroVAnIbOewqczIzkC8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPBZTt4pzkaaGDIAhqnOhAOwBhzeHiyfhvcNG2gqr9AnV10XFCJrMWGJE7hB38x7F7GHo/PifeOshhe4JM74Bkct5fRCizs6f0tdEW9KlQr6MxQjZyBP6+Km7XnL1WDajdhUUv8bEyn6jU6G6Jlk+m8br5Ouhvl5RDaogllIxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2vvpqoWH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-237f18108d2so26105ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753726900; x=1754331700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3hmyZvfsTHdwJz4dIDqTvttC6a6u3BEsF8dGiWKG2w=;
        b=2vvpqoWHblnKEOj90Avdz3B37jWPurYdeg/lZya7Ptkf23uD8B9wXrLUCOn9F4VkPe
         8beMMMtFJxSVqwiKo5akZZySU1wt0h+avefCmoRVgZJQV/aoifsdajPGiqtjMjctjgK7
         1p67y5w2nhWQdQSlN0Ytu+9DUVQWnURkxSkHZBKtV7nmg0GcF8RASh059DUd6H8pEpAl
         oSuqeBl3qMN1vZRZeAzr3ZAbVFoX2XcYRyvxU3ZGsNdZWXmLx+NLBVPBiU4OuvLvJHWq
         z/Bcq6ipwOyH4fHhMFYgkaZgE72mEN+GLlQD/uYcBXfOT39VF7d9gv6zDbjAnqpdNpnV
         ZVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726900; x=1754331700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3hmyZvfsTHdwJz4dIDqTvttC6a6u3BEsF8dGiWKG2w=;
        b=dDJeIrOlpgaV0nzyj3eCdbl3RDFzWgwBlPJDUkPmnTcSso6oP9q22vhOJybAAKvLTV
         mn3IKid2Luj91kSKjHi5jGfQCXoVrs5FqtDEE/P9Q12FPrg+I3GKU5lXfGLZyex2T8Zl
         9mrijDDA4M2Oh51vKv5jqdpyzkCJDQ14KPK1p8c5VC6UqvQU7Bxfq4nrGmUD84ULAz7K
         MHKpFsfd+ONTFycgca1+Tuchn9hJifhe7BUCb5r5ocBPO8TgIBxiOowSREtn1QpmkWDO
         exnyiTcgzkhqEqD2F7aTVZ2sCzKwE06AYCKtAvKvX+9YlkxltJBndyigXcayLjuOf2i4
         08GA==
X-Forwarded-Encrypted: i=1; AJvYcCVGtrotn+8fGBSvdwUJhAEQtjSSVoevv1nWkpq9E8NdKEK/Tt2ZgiUGFuhdj00gQfhZ30Zzx6feCqlJZzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJBZLH9h14TKuTBQtoxl7o/44f4W6NbZhDPdizWKPjpthF98hC
	c9SsSKz2AdVzogajSf6On4Q7Si0LCjAbd+wyZ8oN7bWoA/ImXad92BnoCuEtOkAfJQ==
X-Gm-Gg: ASbGncugTkvEOPnU7+q81Jmv7PCxbXXYS936u7pGGy08APsF/iHqTMeyF/EC0/gilXP
	SGQCySK5M0Lwoi+7oSu1OG6ca7CISEfWKjj0H0Nf1bm1J6PoUPXuG/Rqr+m/J1kIt2QXJzDwjg9
	pc+MFvXAPve2cfcNseA3wUFjIEXzN90B0CEbyfQdzkpMf975S1HIuch0wdGSJu1/sn55YCQXlFA
	uMyf7ShKcluU83tH1mdAIv2srHX2tdTmaTxmock8byXwqgSCBTFd0Xofy6ajbG1WdCvoT9fmc5h
	0q/PW8TiGHK367x2dz5trFfY6JgDDuhJzjZasCCk/AOxJMV+baHzU8PaiIw04HGC9v7PfTA/WfO
	TJ3DTNvvZD97LO1j3f5KFcBQHs2v98+vBCf+smF9EnGewSZsZMPu/aJhIrv6uzeJLxAMf
X-Google-Smtp-Source: AGHT+IFcpgJb1R5wQYv4TfO2DcoDyNX+OGPn08Wv51Nbvqxg+j9hq2EXJS/j5nO2oSPzqax8ItBhqg==
X-Received: by 2002:a17:902:e890:b0:240:3c64:8638 with SMTP id d9443c01a7336-2406789b433mr308495ad.6.1753726899944;
        Mon, 28 Jul 2025 11:21:39 -0700 (PDT)
Received: from google.com (111.143.125.34.bc.googleusercontent.com. [34.125.143.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-768cf25edecsm1635674b3a.137.2025.07.28.11.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 11:21:39 -0700 (PDT)
Date: Mon, 28 Jul 2025 18:21:34 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/4] Use correct destructor kfunc types
Message-ID: <20250728182134.GB899009@google.com>
References: <20250725214401.1475224-6-samitolvanen@google.com>
 <5d7d1ff3-14cd-4c18-a180-3c99e784bbeb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d7d1ff3-14cd-4c18-a180-3c99e784bbeb@linux.dev>

On Fri, Jul 25, 2025 at 04:42:29PM -0700, Yonghong Song wrote:
> 
> With this patch set and no CONFIG_CFI_CLANG in .config,
> the bpf selftests work okay. In bpf ci, CONFIG_CFI_CLANG
> is not enabled.
> 
> But if enabling CONFIG_CFI_CLANG, this patch set fixed
> ./test_progs run issue, but there are some test failures
> like
> 
> ===
> test_get_linfo:FAIL:check jited_linfo[1]:ffffffffa000d581 - ffffffffa000d558 > 39
> processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> #32/186  btf/line_info (No subprog):FAIL
> 
> test_get_linfo:FAIL:check jited_linfo[1]:ffffffffa000dee5 - ffffffffa000debc > 39
> processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> #32/189  btf/line_info (No subprog. zero tailing line_info:FAIL
> 
> ...
> 
> test_get_linfo:FAIL:check jited_linfo[1]:ffffffffa000e069 - ffffffffa000e040 > 38
> processed 9 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 0
> #32/202  btf/line_info (dead subprog + dead start w/ move):FAIL
> #32      btf:FAIL
> ===
> 
> The failure probably not related to this patch, but rather related
> to CONFIG_CFI_CLANG itself. I will debug this separately.

Agreed, that looks unrelated to this series.

Sami

