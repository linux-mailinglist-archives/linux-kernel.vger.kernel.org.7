Return-Path: <linux-kernel+bounces-773835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C02B2AB59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2C81BA4C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AFD217722;
	Mon, 18 Aug 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oLVCclbF"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012435A297
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527127; cv=none; b=QpttyV/wi3RZzbp8FPLCVNBTJ7I/uRHdaEm6QTKWsoWLv6LW57CbkJVr0WMyF/z5f3HgN8MwC0Pj+Kn1EIIN2QMYLzTbhmKibPFTGu1AUMojOSXU5wsRYqDhXh7YQdHRErt9QJks1fmJmks0hsMA81G1K89GtEE1c9OeCe7GVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527127; c=relaxed/simple;
	bh=eAzCytEyJip7F9/ujfFz6fHx6PhzFC86Nee1Y1YCmFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggp8RuOkYmmVlq9db0c9rzttqJku03sEKyad9AYTdZhLKRv+I9pebL3akHvtP7BuhsNhsjaJbNunEuThjfsqrxw2RAPDuywIbWW/rUCr7KbkfhZqKxcnlVsII/midizdM8r/LGTXP8mgxA8gDSE6xxE0fJnAhKVBdaNCS8IEJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oLVCclbF; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88432e1b264so27812439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755527125; x=1756131925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FyQYJ8E1IoELk0qTlvKHUstdV7nwQIqLjOnOuTovC8w=;
        b=oLVCclbF8hbD2k8HOXgSdYpAVvUfX0vTHN35X5ws+CbWapXMfkP7hiVyGicGYERjvB
         XZN5vG/F71xsO0ryhJRUx9WN4DDFDmXKkpdX6AzfnjiON89Zc1nCvZgg29Tv6M1ovz5u
         iQMK2lLeN0zYXdRu/3LVG2Sew0f0oErCx6m93Jwz6HhBu0+QYv0NSSD0w/XoCHQ44u8i
         NF0WSGQ1o/g3w6jD2tbL7SFHy95fAKCcgAVkvTS0zxkav16OP9jmDvE1opzBGlrRl+27
         Xoq2KAfbaEtogLnPoX24HCN3D5+9jMrf0Ru9VAMmc+QjHIYKQvLP3pSwbKH/opG1ofXz
         /FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527125; x=1756131925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyQYJ8E1IoELk0qTlvKHUstdV7nwQIqLjOnOuTovC8w=;
        b=uWHe5FZMRDAk3Um5bqoVixZ4Ixee+aHvCrCTfK0O2NJ6dtBtwjsOczYHJTKI8CRsju
         cFY34lBaGH+RTLPO3Xdzz7jdVPTfsTKx8zkp1zSSiudR7X0Ps9mWWsLjfxlnh0ye2o/Y
         W5SLSEnTmqw6mWz+C7XVxS32CskqtVdtu2c+HkjD5x7v568bA8nCBHKMav5a/rGgU8WU
         5AOeCZ43N4phWr9URAJMBbzcGJGk4c65IbIujJjUBw9LODY0QdgeFSYX6CCzzQpaesoF
         QD2xmXnED19iEDm5+Pw20bdHgvwrWwf7fwL7nmGlhSpXyen0HR9VLf1TghxY7C9GgouP
         NGFA==
X-Forwarded-Encrypted: i=1; AJvYcCVaaan8QfqumB9yuHNzP5nEY1lrHfGsulGK2dtHX5EXZ/CObXsGTPlRFRxEfTmSB7T0rlrTsIvKhUbzIG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpmWznICJh/lEOrsGFZ4sEah2hn58v7LoLRHYi4CKiGd3nuVD
	ZO7FO1vy+GickqxiAciTHh/7t8+SKMTDLmQBXQFf7fU1A8UEIIi3aR2akz5Ckkhz684=
X-Gm-Gg: ASbGncsgo5dmWoh0En4O59b6pVI62wUG0EVLZnI9JVbLB54rZziANWuELQ56CQd4FFd
	O2L13yDTcPxtOnDiF9aWFqkTFQyisOi6CFkEMC+3kKddNhcNkKGurOBaPa8Kjruv6fE0Ndjl+7O
	7CjQAjoqJdZ/gmBGI0iQPxFd3iL2KINrlDY9gRle9ew61N3tK5kKwogPFbnuCKHdHahbdbJ8Fad
	y4bHvBZ/dBXoRryxYJCfHrmiFiW012/fLwxfCgFK3ZCBvjJjXVBnhCz125DnS645XPWNdPcwLPS
	6LJ3E3CeeFUOZL8bJO6ivEseU7SZ2uX9mm+H6ZYE/lzAvr6ti9ktdIxq3YXJIgb09Gupf+XA7YM
	S+QWAyU1eUtXJ1m8Tpsc0LgwJ
X-Google-Smtp-Source: AGHT+IE64bGylTNTCod6VJPB6Kdqx/YvIcxD3l3x6WiSKJyPUG0tS+DbyXFafnmRow5N9BI1j9Ev6A==
X-Received: by 2002:a05:6602:1687:b0:881:8a24:55c3 with SMTP id ca18e2360f4ac-8843e36de4bmr2011895139f.1.1755527124401;
        Mon, 18 Aug 2025 07:25:24 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94999fe0sm2564173173.57.2025.08.18.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:25:23 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:25:23 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: KVM: Correct kvm_riscv_check_vcpu_requests()
 comment
Message-ID: <20250818-3808a778aca8606ddd126ebf@orel>
References: <49680363098c45516ec4b305283d662d26fa9386.1754326285.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49680363098c45516ec4b305283d662d26fa9386.1754326285.git.zhouquan@iscas.ac.cn>

On Mon, Aug 11, 2025 at 10:18:29AM +0800, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> Correct `check_vcpu_requests` to `kvm_riscv_check_vcpu_requests`.
> 
> Fixes: f55ffaf89636 ("RISC-V: KVM: Enable ring-based dirty memory tracking")
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/kvm/vcpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index f001e56403f9..3ebcfffaa978 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -683,7 +683,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  }
>  
>  /**
> - * check_vcpu_requests - check and handle pending vCPU requests
> + * kvm_riscv_check_vcpu_requests - check and handle pending vCPU requests
>   * @vcpu:	the VCPU pointer
>   *
>   * Return: 1 if we should enter the guest
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

