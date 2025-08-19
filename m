Return-Path: <linux-kernel+bounces-774634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F25B2B554
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F01B21E22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A1E13EFF3;
	Tue, 19 Aug 2025 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jwPZHbEC"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F08BEE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563448; cv=none; b=cH5mJ6z35xb+ufPdW13TB01nt3rHtjpRFzOjo0dhoEj1hBwtJ+hr1ZVoBeQfqeOP/l7SMZMfV20eDu9IzNB8Cn8WgWnh9XuFp+lX50vkbAcjKpTK1my3zyYO3c3TJKq6VVnzD6S7SySZ2qUv2Zxz3m9PXG6zROmO3sbyWiGON/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563448; c=relaxed/simple;
	bh=7cSAwm8Mpm474gJFqJTDSfYjShfJlHAUKQHNp9cO/CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoLFAnNEGukD4CnzWU9KC6zynTKFTh7TVeSnvvAEhsrUH/5INtmjzJ0RstN3GgWaF9To/hmZlw6UpVQeYyuipzv2sCaEhAyNIn1BrtfoOv+ZHWk2tLbURb14qO6wtDqi44GEzNejlU6bTADFXs6yHZvHBovSKOF92cqRRicVoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jwPZHbEC; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109bcceb9so56492611cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755563446; x=1756168246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hLw3Ly5lBpwG37igk8nIXvrjC9WRvilq8gEy55nQz4Q=;
        b=jwPZHbECeV+xOkYEcU+z1HIZtR6xcdUSyjRWedKpftrEJFHr41eUThABrxS2BmG+EE
         0HQIz2xY/Vx4O95K2ZGsU9pkOL1ONpTXqZdOY2kCgknY0cHgifEsXZ+Do9zeM/dGLevg
         LbQFFFTKxyBRLP4VvDwd2RWmsWptbxsD23B3RKzx/0YHOZm9aSoYsVj9Z/wuhIwTB8at
         2cUTJAV/H/HOD7TilX7at3nETQ+dDaizDMTuRqqhEIEy6gQ+Liv1xk6bIfZVFJlWovT2
         tGFOgFYgkp4SP/QOG7O1eQLUOthO47spiTiV7YYb2nVdYsJsTrN7vJWgXjUj3DQlpteP
         yvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755563446; x=1756168246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLw3Ly5lBpwG37igk8nIXvrjC9WRvilq8gEy55nQz4Q=;
        b=txT1L1dM65p33Zgx32Xn3+zEvgjrtGmv4jQ22ezqgEEjt1LjKeACsgCI78DfG31a4Q
         EggYDul08lpxRekGBGzszshAsiezeHgMsxMFVqiFNj1x2R9RtNt3T7J3HgK2RRvUxM0G
         y/9WjKIn1WZP9WIjHdtynxwRbbL48CJw+RSNIzGdRBS9s81p83L40LXV/wALKldXB/cF
         l+3U4andBMTjjXUgnZZrA9b3RIWIYU+uHbA0cd6mBFnNPaWrlaKb19lk9mX76N9kzQ+Z
         EamFIWI4BD1801odZIyujZvZNJirtLW6C90gI1hEBkGMtBs7qFzASMPhDZuYm035y8Jw
         5gQg==
X-Forwarded-Encrypted: i=1; AJvYcCV645GNxP3PnhucNVTHns/dj5qJ6zKJ3EGniJ0LFda2a6peSQwea80aTX6zMPBejkvCyBtUrFv+AliHJho=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjz2DofdxWM+y9+wgX6A+DVS65zeRO1PjKCQGeDfqxXfkqIDq3
	zCoCy2H9jrd8XcYl7UL9+62YHqxj60M6sRIvVUrusyzRn+KILCn7xnvHFMPaj+LYOKuKqTLirOG
	0ulWKunE=
X-Gm-Gg: ASbGncvbMRtpOORnfsZ2RBPExg4aUKvcexwM3Af3IEEjjPjWuzKXDful1yf94pVHPvB
	vtsKYvzktRhLFZz/aV293ICaBYBK9e/tLlQp7fN6S4N3aUSpFvShz5cfUzPfAwECSjxG3YHNI8N
	ndfI+XDZxmvRJz2nNE117FNDy+TMrh3H429eI5xMYGNgprpYfOtG4SX024Tcc/7JMT+kXB9XbjW
	nMc6nvP/XooC4+FioyCuIIoo6G7dGJ7Lq21JuguegSqVFCNB0AEe3Ids0JGE67Gct+Ol68iV1M1
	wrShzvUXfzst+YjRtdEJABiM2ofqc1nN8ldaTwI3q1cIAqROwU9lMhJ78UJuQrROfBebt2BT8mQ
	oPjxSoLR5BlwdT2eFOHmgDdo=
X-Google-Smtp-Source: AGHT+IGBQbFzX0nYDgxxHDXJuUpwrISyNXTFy2dbw5LSBC5tG74mcZCK5FKwm3AQdhXjEGg8m2Q7VA==
X-Received: by 2002:a05:622a:312:b0:4ae:f1c4:98fe with SMTP id d75a77b69052e-4b286e216edmr8455701cf.34.1755563445791;
        Mon, 18 Aug 2025 17:30:45 -0700 (PDT)
Received: from localhost ([173.23.183.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc584c3sm58679171cf.17.2025.08.18.17.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 17:30:45 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:30:44 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Dong Yang <dayss1224@gmail.com>, pbonzini@redhat.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chenhaucai@kernel.org, Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH] KVM: loongarch: selftests: Remove common tests built by
 TEST_GEN_PROGS_COMMON
Message-ID: <20250818-2e6cf1b89c738f0fb1264811@orel>
References: <20250811082453.1167448-1-dayss1224@gmail.com>
 <11d1992d-baf0-fc2f-19d7-b263d15cf64d@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11d1992d-baf0-fc2f-19d7-b263d15cf64d@loongson.cn>

On Mon, Aug 11, 2025 at 06:49:07PM +0800, Bibo Mao wrote:
> Hi Dong,
> 
> Thanks for you patch.
> 
> On 2025/8/11 下午4:24, Dong Yang wrote:
> > Remove the common KVM test cases already added to TEST_GEN_PROGS_COMMON
> >   as following:
> > 
> > 	demand_paging_test
> > 	dirty_log_test
> > 	guest_print_test
> > 	kvm_binary_stats_test
> > 	kvm_create_max_vcpus
> > 	kvm_page_table_test
> > 	set_memory_region_test
> > 
> > Fixes: a867688c8cbb ("KVM: selftests: Add supported test cases for LoongArch")
> > Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > Signed-off-by: Dong Yang <dayss1224@gmail.com>
> > ---
> >   tools/testing/selftests/kvm/Makefile.kvm | 7 -------
> >   1 file changed, 7 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> > index 38b95998e1e6..d2ad85a8839f 100644
> > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > @@ -199,17 +199,10 @@ TEST_GEN_PROGS_riscv += get-reg-list
> >   TEST_GEN_PROGS_riscv += steal_time
> TEST_GEN_PROGS_loongarch = $(TEST_GEN_PROGS_COMMON) is missing.
> 
> BTW irqfd_test in TEST_GEN_PROGS_COMMON fails to run on LoongArch, does this
> test case pass to run on Riscv?

It appears to. It outputs the vm mode created and then exits with a zero
exit code.

Thanks,
drew

> 
> Regards
> Bibo Mao
> >   TEST_GEN_PROGS_loongarch += coalesced_io_test
> > -TEST_GEN_PROGS_loongarch += demand_paging_test
> >   TEST_GEN_PROGS_loongarch += dirty_log_perf_test
> > -TEST_GEN_PROGS_loongarch += dirty_log_test
> > -TEST_GEN_PROGS_loongarch += guest_print_test
> >   TEST_GEN_PROGS_loongarch += hardware_disable_test
> > -TEST_GEN_PROGS_loongarch += kvm_binary_stats_test
> > -TEST_GEN_PROGS_loongarch += kvm_create_max_vcpus
> > -TEST_GEN_PROGS_loongarch += kvm_page_table_test
> >   TEST_GEN_PROGS_loongarch += memslot_modification_stress_test
> >   TEST_GEN_PROGS_loongarch += memslot_perf_test
> > -TEST_GEN_PROGS_loongarch += set_memory_region_test
> >   SPLIT_TESTS += arch_timer
> >   SPLIT_TESTS += get-reg-list
> > 
> 

