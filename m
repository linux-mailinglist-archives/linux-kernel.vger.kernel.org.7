Return-Path: <linux-kernel+bounces-774452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DC1B2B274
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C572561495
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05058222578;
	Mon, 18 Aug 2025 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S9lZQARt"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D23A3451D8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549243; cv=none; b=ClkXlwwkMqv1KyefYj5erXGUqFeRAMHMWFep/cn1dyND/XwwVkP8NjLT7FCSTaKF84/VjAfR9FnMsGywURndzK8qZVZYAWDfwQNgfuuQ171UK6t4kitxOYzvVE5Q3PWWDt+VoMNzMPIO2mpcFwj5+69I3DXCbgktQw7xEtyLGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549243; c=relaxed/simple;
	bh=/dvxnJ7wY7jaLn1XY7+LGBz3G+AXEAX/pF//VdJh4EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D48qPGkrgR8lbLDttViXgjuxj6VXdSSv8vDDczHra8vXjQWA4GDnhXEaGkxCjAKJLUdwrfXJMypO+waJCU0ZfzXc3NkPnSmFvDhLrzFYhV0hPPB01FqJvWGUmQ/M83FkqD+ac8Fc8KLkAA5TQsI9KG+p+v3O5D9MqUQ5s8EkAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=S9lZQARt; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e56fc0f337so29660425ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755549241; x=1756154041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjJrmy2stspTCrvdXY1WIU0SYuKr2K0lvsiwRgTRkkg=;
        b=S9lZQARtfycaRGokGWKyRvyMAaKusty0X39WhTdGiY2TaFhNXqC7sf0st7wBQOC0Qq
         IQGkubFUD8liKEwWnLI4bDdfuDehv5EQoIHi99eH+qQuU8GAuPqHVLmrk8DGCzXTy593
         JiCWOzZFZVSdJdP4XKPzLTUVzh5dfOIYoWV81/a8Y+kdrLJXRPQ1joDBMVQzid3vkZtY
         FrjOFIjtIxBiWmq/MQQsDgilIC7zQMd1CS4KE26aQGD2EqzVp0rrjOlANvaGV2duesjP
         iYUgS4EXSFN2iVEkivLzajBuDhv+21YjyZHHswUfJ/xa4b8R0TJp5XbvkyeqxglpN8uk
         n7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755549241; x=1756154041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjJrmy2stspTCrvdXY1WIU0SYuKr2K0lvsiwRgTRkkg=;
        b=RQ1GHiiMdkKF7g/bkJ29XBOamcwbsXRR61zHYfGeavnSR/CAQ3/E1hSomnhuO0et20
         LOMBoPoVBGgFkOVOKCQa2Asxm9149g1SzdxJBPg4H/XS6CT/rY70a6EswNXWP/xX5D3u
         Nz/qhXtZkCmemo3ahuRxIxU3eSCzr+dfCSz8R80fL/5TFORX5WWano05DmUvCmInHD/S
         nMkePd835pffc9H6hamUe+0EhQ2qu9/7qg62e9oLP6wjvgq6qlip4Y+FkUqRa3MfPmft
         QsWUVUbpYFUVXmBosctAE1N5XwZ0Pp4ZYKKNDO4L0hHxj/Fg9ycllIUTGgS//Nq9B8ZB
         oAMA==
X-Forwarded-Encrypted: i=1; AJvYcCWoYpljjRetQvU1pzW5RhY+VtXfrw+J7tUdyoZVqWXLAop2P2GLjOrOtGRG+fKSqPOC23tlBlJ9v9uRmbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLsuv3rr1hEz97SVyd82z9FZ9J25cHSgpalqg1vO3FQKIcKOk
	ZgFR8JDdgXxVKauBJBmKl6CG8m9YcOrF14tRS3FinFCbgjuksc6qzAkbG3SmhSk+sic=
X-Gm-Gg: ASbGncsJLeEVUw4pKZkMBkOCyCK/F6VAWqsdk8aaty1tLpcmmk1NKrQdMCDGfG9xeBR
	B2HabohE7dLKsBizGsGxmcICjy+qg9kL+IHOmVoGPF4q+p8u1pq6g9rIhrROG5ndXb78Hn+1j71
	PqNMaGvseCxDMZu4mj2kQeljCj+k4cFY+Np5Cdnqla9LVn5RdFyHzTm0Fd20tjRqO7f67v7Tk6i
	w+UUbIvKFGhwJ7ghJJXM4sAXRbQe77ZHUb+qRyzZAdMs+TEkGeyXF9lu//f0GhptaZDV+Jr/j6y
	XH+0BpCVLO03EHHlFCzHmgTIy+0Fwu/hqOhRCLv2o4XdZXsejlF0/NaoDwtJzw2Mm3m7s+QJWDf
	TOohjDi3vfztUI+1oGxfFXzH+
X-Google-Smtp-Source: AGHT+IGRTgu1GwXkFLnvLr28LEmoS61swGqzhfNvkiuvx4bYf7qu9UcnEVK45d2zFEeHx8uZ9BB7/A==
X-Received: by 2002:a92:c267:0:b0:3e5:70b0:4f9c with SMTP id e9e14a558f8ab-3e674fe559cmr16147595ab.6.1755549241100;
        Mon, 18 Aug 2025 13:34:01 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e66c6b0b12sm13099125ab.25.2025.08.18.13.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:34:00 -0700 (PDT)
Date: Mon, 18 Aug 2025 15:33:59 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] RISC-V: KVM: Provide UAPI for Zicbop block size
Message-ID: <20250818-8beeedd83482f6e618be2ea0@orel>
References: <cover.1754646071.git.zhouquan@iscas.ac.cn>
 <befd8403cd76d7adb97231ac993eaeb86bf2582c.1754646071.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befd8403cd76d7adb97231ac993eaeb86bf2582c.1754646071.git.zhouquan@iscas.ac.cn>

On Fri, Aug 08, 2025 at 06:18:34PM +0800, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> We're about to allow guests to use the Zicbop extension.
> KVM userspace needs to know the cache block size in order to
> properly advertise it to the guest. Provide a virtual config
> register for userspace to get it with the GET_ONE_REG API, but
> setting it cannot be supported, so disallow SET_ONE_REG.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/include/uapi/asm/kvm.h |  1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

