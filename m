Return-Path: <linux-kernel+bounces-774449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9110AB2B276
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38D03ACC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1D2223DDF;
	Mon, 18 Aug 2025 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="F5vg4gnA"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827021C16D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549137; cv=none; b=ffumj3B6fE3C5n9i5pTDbTil8rtWBjjTiJxKRfek514aGMipT8e3A11z0One3mfL54ydssSEE9kSBPOFuVPSHuMSs9sYYJt/z9t2NnKSa/PtyEwSHVJqBRjahRHk4bK/TIZ202fAug8TpYvIg69O3S+2mjH1qMOcUz3GDyhvth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549137; c=relaxed/simple;
	bh=auyqtb4rVQCIYE2YBsgUNUAZb45KHzNR0n+asi5V4Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8z7Smg8i1OZ0thgL7w+7SZi62vr8BLWZm8e2NlUMkIwk6E2lc4g4bR9pp9TLSn/wGYbpNkQRs5j5ZBEDqaSVp8l2kdTtq13jC/o+fXRf4BkJcdCQfqe4ODn6mEAKbT8qmuz8gxph0hsY9ACAa0lHnmYovRPrnV+8IneVP+67oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=F5vg4gnA; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e570045e05so41690485ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755549135; x=1756153935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Vn7KGvnJ31CxElASYk+NIfs2sarLTulRtjwYt6vxT8=;
        b=F5vg4gnAD+odU4VUqghw35yPowRi/dJkzdTkIkZCUPL32aoSDMmIUVbOwNYVRRhqsi
         VLOJYOMYeqmkU4gkJvfmbMigKjrsqG1DNAgE9I6u0IR7+npFaAgbYjr1N9bt5dONYFcf
         ULl/YG5u/NqwEhTC9EDDEvPj/aVZ/vBRw0QGy60F9ZB+vtK6ssFVNPtoR+/RTQrd4p3L
         nPQd/CF4Ba33reZG8QzyuZ9cLJN7ivmwJfykeS5qioKqDaKIzpE2lsr5QPSKoY7rj5fX
         mPlI6rPbIeou8Z9DM+iTwrv/CqKpNIsDe4Bw8QlmWH0SVM1xpog9xofkGkFfaZ7BBprx
         tz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755549135; x=1756153935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Vn7KGvnJ31CxElASYk+NIfs2sarLTulRtjwYt6vxT8=;
        b=SMZgIgrAi6ZHj6JPlLXnLis/+B5GPZ2OsicKcw6gCSqZhVBFfvBvjRc+5n6f0uIjPS
         /jFFj9Ftax4wx79qIDhzkN1ernmjFODsquYxD6dpH+NQPLvOBgwSgSQu5hF6GhxRUbIE
         AEtVRKmRoENoM2R3LZHjETHk9qAe4RFrMFcM46EVjrENftiBaqRthTyRHTnHPNamOMTM
         1SjtDQCAveLWnfrlatWWxvg3dviyFlZQQTIfil1IGNAqDPoGylwzzJLX+qBCaotuMN/e
         RWoZYllPcP8rI4ScAc6eoemkngRkbUuwo0BjRPqqaHLaXUJpB41kadpCFAcCQBh0+EtH
         ZbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYcFQz6WkxjkCj0xs4mqJmU03sl48DtSlQ1up1DjFMWySwaouEXRdw+RHyVNWEa4xPZF9yjWLDgYugll4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEh3KyGQ/R3I4/n9L4xoTSaAml0G/20om9ESGLNSek64WD7yT2
	ScveiqdPfyYbd+PPZx0q/2O6naGtDUw1eYcdseVcHGkGPkutjkd5kUqBL/kN8+qGmds=
X-Gm-Gg: ASbGncvrwSpkkc5YLoNigSfuXS3QI2V/BzRSHz8sTvi/ggB0GsIOjwqEGafOFhNfon9
	USZZTwjssxaCXSl/cugV+Ibzvpqu9GwR6X2Sue81HgDklRWGPFP5zHSyyYEfFkJtxWrA0cNNil7
	IjS9iCzP+SEds0JPN3I2/RuTjwWoZWj458ZvwdCYCwFGWqAhC9m/q0exvgzFVLl4+dphWRWAH+b
	4sYwxGABpx3Ql8m5/nTmJ+HyrQ4wNNV+OGBdsEr14yQIqGZqQXAF+u9Wb3PnwIVk3mOMrrdtO/D
	l+bV7EB7K0vdF/nkUvFPIHFSib72HoOSnhUayUyTI1qh7F0zqakNG6oLVIcFovZ876LbPGlMH6y
	HqXQcW6t8cUk95U/RSkQZuudq
X-Google-Smtp-Source: AGHT+IF/UJeN6VdS70sUHdd0WRTBcf8Mub8fIKvWwcAVcgm38V3gFnMMkeNmKxZ5+rkOte8i+tJYLQ==
X-Received: by 2002:a92:ca4f:0:b0:3e5:1917:585b with SMTP id e9e14a558f8ab-3e676638e2cmr1709575ab.14.1755549135023;
        Mon, 18 Aug 2025 13:32:15 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e66c6b0b12sm13085315ab.25.2025.08.18.13.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:32:14 -0700 (PDT)
Date: Mon, 18 Aug 2025 15:32:13 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/6] RISC-V: KVM: Change zicbom/zicboz block size to
 depend on the host isa
Message-ID: <20250818-f6b7d56c16a41351e90ca804@orel>
References: <cover.1754646071.git.zhouquan@iscas.ac.cn>
 <fef5907425455ecd41b224e0093f1b6bc4067138.1754646071.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fef5907425455ecd41b224e0093f1b6bc4067138.1754646071.git.zhouquan@iscas.ac.cn>

On Fri, Aug 08, 2025 at 06:18:21PM +0800, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> The zicbom/zicboz block size registers should depend on the host's isa,
> the reason is that we otherwise create an ioctl order dependency on the VMM.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/kvm/vcpu_onereg.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

