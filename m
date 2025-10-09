Return-Path: <linux-kernel+bounces-847243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A58DCBCA568
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC233AFC01
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAEF23A9BD;
	Thu,  9 Oct 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nVYbEV7m"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686EF1632DD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760029800; cv=none; b=mixHJ2haSqUfkkwk4zw1Y2hO4JIrBhH4I4IIqxkklOl0+du/C7iaLEq/k3qnxIZ1gJzCHDaqjscPjUjH+hUvpsKv8JSvk7tH47BFnZk7FwnSNT7t81OCJnyiV6JfJZBL3oHuBG5uQ4KYAfw2DhnhFB9RY29dnzH0mDbddDHeEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760029800; c=relaxed/simple;
	bh=z4CFvXGson+4pta52BFkmrjbxTkYt9+SfgzIb8xKMhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH1zDL3fpOC7z4Ql5sJ4iooxhDBK96JMq1Mykh2ukaMLPxV7JtqMlOStNg5B9PlhFCO+7Mlkz6J2dP0DgR0rpcH/gAANm0S8AUh38pY+rVHRGJ3TQ0J82PfgYA93vlaDQziKg4JYadyDkCLnk+Kae6YWdLgIcLIIO5ltwP0K8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nVYbEV7m; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-92b92e4b078so49631939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760029798; x=1760634598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTeDxHV41BcjEs4ZzLufpAg+KIKFlFSe6LLaLPzOlwc=;
        b=nVYbEV7m4R64KSc+OVi3nCGKyzIqsLZIXQcSCmVU1Jg5jDKGBu4AHir7DwCYEMSXdu
         5wrp7GY83Tt/BUQqmxkqsiqLcsDeWQtuaBZ3O1BifVKyur0Veumht5MF110yLCe8XeHz
         xesOvDM2czVPX3UCu63mSmDONvJ0FdXBaNx4GQ8UX2hO0ejh71pXuGBu4InIBe/uMKR/
         IPCFw+lio8ap1i7bB7cTNdemWBB0HTY0PpFtTzw0IHQcD/RLO+jeYHIxEQSRPRGTHRXJ
         /PfKYYHs4ST8p81avuxMvaaVRLjDN1y5MBjHgx2AJgEhR3DKFvVhoNvQizTMkibXU5wZ
         pCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029798; x=1760634598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTeDxHV41BcjEs4ZzLufpAg+KIKFlFSe6LLaLPzOlwc=;
        b=N6BS2LyCPaq+ZtApiQrRwd0gAse3OXWQnOEvfSi22axvoZcthSwc3U0/+nUz+ZE82M
         4isksuLrovqsldAxpQNELroDu1I+V7m5lUcWQx45xSTu3qkjCNoNII9KzdKywIvLSUP0
         iIgwg7D51xRNNqxQCbAPdVO15gkfaJBNATfnbXlAYsonWXT8AKvANovKszaDiebmDtAz
         /a9ta1c811BC4ciOo/cQL3HJaupK2Al+WZaOsZEzAJXuBVhofOCGhSpGumwu83OMPpeb
         KuD50K66pH/FXQsfotrn8vNI9uyLd5FekU7JSjzNCoPnnL1nCOrjwmE8KSmLpYSt+h13
         E/8w==
X-Forwarded-Encrypted: i=1; AJvYcCX3F2Q10cO+T8z4XZCh06A6Q5rDzobpwnN0f+0MZd99PFV/7KHyBeaSBcTjD7X0R0slp8NzenRL5m/1kbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+khT9OQbytKJzCBQiHWClhixV7lb8kQBPXsuaJTlD7Mkyr9H
	01pjecNuyguyYPI5StSGZubJMYNqWVPgsjVLwHg2+EaJvcnkSQzGqYfFJobOm9YlWnY=
X-Gm-Gg: ASbGncuMHd1KR1fN0FK3hbL+xVAJV0RHJSeNjaJuQxXkuh+ckJU/2DgHgHmmAbnJUcW
	JGOdESws8BS96h3B7S8dAPzRQHzzhpsALTRYUUeXlvrgYk+X5Vw1AUyUmSURLabnW9jktk8kyO3
	ZE7eqfDIzIcWU6hqYhznj6Eugb7ZYzR6WAvhz6FCR9Y69Q6br9dtCx6lLMgNjUcQ0/TMIrWV4WX
	aFqPEOZFkR11HrSWD+IPGVvzJsfIwL58z/4l+Wv+pjt2XeCemEo9DrfUAty11m/fDTq0OeXtK1Z
	Fu1HY4mrMIUQkiGRf/7LBVANT2dijMy/6BRD/p4vRxOBnn978RjwiZtxn1jppLKSNImHo5wtL7v
	kSYNmJjspyPGP4CswaAA3POeHPLoPQhkynS6OMz9kVOzXkbYWuQaOgho0iv4=
X-Google-Smtp-Source: AGHT+IGjllGdtDWAnTrCzVKrcM1t+/BGFwh2qkqJDVXQhEyBcLiRTPJa0KrImioBzGzUP3lZRVUBCQ==
X-Received: by 2002:a05:6602:27c9:b0:8e8:a857:1f89 with SMTP id ca18e2360f4ac-93bd1780c1cmr894428639f.3.1760029798409;
        Thu, 09 Oct 2025 10:09:58 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea80655sm8164172173.34.2025.10.09.10.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:09:58 -0700 (PDT)
Date: Thu, 9 Oct 2025 12:09:57 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	alexghiti@rivosinc.com, shuah@kernel.org, samuel.holland@sifive.com, evan@rivosinc.com, 
	cleger@rivosinc.com, zihongyao@outlook.com, zhangyin2018@iscas.ac.cn, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v2 0/4] riscv: hwprobe: Add Zicbop support
Message-ID: <20251009-440720dc2e40b8a0b8296956@orel>
References: <20251009134318.23040-1-zihong.plct@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009134318.23040-1-zihong.plct@isrc.iscas.ac.cn>

On Thu, Oct 09, 2025 at 09:41:50PM +0800, Yao Zihong wrote:
> Changes since v1:
> ------------------
> - Bump RISCV_HWPROBE_MAX_KEY (modified 1/4).
> - Add documentation for the Zicbop hwprobe bit/key (new 3/4).
> - Add a selftest(prefetch.c) for Zicbop (new 4/4).
> 
> Add UAPI and kernel plumbing to expose the Zicbop extension presence
> and its block size through hwprobe. The interface mirrors
> Zicbom/Zicboz. This allows userspace to safely discover and optimize
> for Zicbop when available.
> 
> Background: Zicbop is mandated by the RVA22U64 profile. Downstream may
> combine the presence bit with ZICBOP_BLOCK_SIZE to make profile-level
> policy decisions or enable Zicbop-specific optimizations.
> 
> Yao Zihong (4):
>   uapi: riscv: hwprobe: Add Zicbop extension bit and block-size key
>   riscv: hwprobe: Report Zicbop presence and block size
>   docs: riscv: Document hwprobe for Zicbop
>   selftests/riscv: Add Zicbop prefetch test
> 
>  Documentation/arch/riscv/hwprobe.rst          |   8 +-
>  arch/riscv/include/asm/hwprobe.h              |   2 +-
>  arch/riscv/include/uapi/asm/hwprobe.h         |   2 +
>  arch/riscv/kernel/sys_hwprobe.c               |   6 +
>  .../testing/selftests/riscv/hwprobe/Makefile  |   5 +-
>  .../selftests/riscv/hwprobe/prefetch.c        | 236 ++++++++++++++++++
>  6 files changed, 256 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/riscv/hwprobe/prefetch.c
> 
> -- 
> 2.47.2
>

I'm not sure why patches 1-3 aren't just squashed together like commit
eb1003970940 ("RISC-V: hwprobe: Expose Zicbom extension and its block
size") does for zicbom.

Thanks,
drew

