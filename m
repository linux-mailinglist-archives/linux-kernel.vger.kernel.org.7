Return-Path: <linux-kernel+bounces-724867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C35AFF7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2921BC748F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F2421B182;
	Thu, 10 Jul 2025 03:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZpitKHQU"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0FC1754B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752119121; cv=none; b=Wj0pIeLlYDqzOvXBrc0DR5s6h7qUeu4Ajru1X787CJyB6+WAXiwJdO2hzrm1pk61lD+WNc5W/YMbeB0frliQ/er7D+Xi6LEWa+vnxHaXbRJKVbvlWmnnNL9+kq9kstnq403sX0KW4TvrdDTvEbdaO4z2+TPmW60/cDOwYBcHHeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752119121; c=relaxed/simple;
	bh=XUU2EwDs3wTQud0Cl+WmDya5o1Vo+KLmUY1j/ihV8Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw3gqmafy7guiDiAgEomN8aBPAwXbsQeDKfy1mn3fbHfAWF9FtACQh4cT8hD50pReeydmSLdB1+VxqJ14V8dIeLagSAm1Gax2Zc5nsLhR0VD2divI1VW0Z764pkRoN2wv4/MyJSlwdN2dcf8kyW1A/xDy9MOmYuTrIPALLLfQk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZpitKHQU; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73cdff99fcdso292628a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 20:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752119118; x=1752723918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MoQm87c8Z8k5cIMa6HiSZvjUkFd8qA4WK0ftEEUX+Q=;
        b=ZpitKHQUWsKs3YhVfCK/I9In3AihAWxsw49Ioxq8oZHiSvrTiCS+6aDAjMRpOV0jaY
         E2pQbO5tCOzY4e63Iz8sF/7Bv4iuczGoOiBpiz0CBKE+IZkC7ZeNn7xRwqSmuZeBjTLE
         hSX7G20aCU556h3reefpVOFC3ttD1XeonqmOo9FWR73SrrkuPjv2h58/0bFE8GofFtab
         lDaf3OrT7WHc8LdGYECw3Qk9MxybrZN0wpQc4F6jWC5u03qLw1ByPPFJvbNgCDeyVGYm
         J9607o2gj9NdXoR1ViEzYnffXv24CqFaCVN7NKNYONKPNE7Qiau0MzYqeLsULaDTnIqr
         ty/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752119118; x=1752723918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MoQm87c8Z8k5cIMa6HiSZvjUkFd8qA4WK0ftEEUX+Q=;
        b=bxWWsDs5225sX7da7LP2+jSKzd63Bqlka99L+oqoXyLCFvBoB0KOw4R1+PetDwgXE/
         k05X00ZkM43aOKuNhECubhqQS/750R5Db4JHEFvfw9uAhKHAiQiqblQ9otPXHnfEzBXP
         qAImMKx+PMFc97yRZZ5biIDX4r3l73kQBDSh4nO2JR9BnFEb9ZxOdRlhuOe7p3Om0R9J
         BgpoiAYqdObspSW+72pYVUpHGBa9Xrn2BwUcp1QN+uTxloQ4pnsG8jXCIL/05Xa+CN95
         LVYi9tf6Zh6Ug7ca3uoLRuZ0kzAUBtblZSemObpg9qcj4FkNFPsXTB//o+uCl+/GUcZx
         8Nog==
X-Forwarded-Encrypted: i=1; AJvYcCXHJXYL6NM9sbnIxyCmFSJLALN57+BtXKNxgQS9P0VuqpDlb+KaXYlfaG1tuW6+SCuZJFalMKhu0lWtk+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRckfuunYt9/zg5yu8NvJq4iktarJfAntUdETxfQUV+t4kvTf/
	qJRcSljWZ6+c6O2+76SMDi6IaT+IJr5y/j1aMYhhXQbv5EBw3mRpF+i0vy8o7kY/ndJK8y2Yjpf
	b9eAPxSBrOtgN1arZDPAxvtZ547bA0+BNGU9cKLQXPg==
X-Gm-Gg: ASbGncugWU8iEqetKFaEyww6lRlQq0lVGqs8ynaQSNcdWMi7g6wqJWIbzf3RsWSQSX0
	7vklBuKTYOV5hDGhlV0VGo4gk4ttKoCxTaVKL8IQvPjtcLMT6JYQujc3qfVPILkdeG6JfSi2IaH
	5OD9kTTbjU691omO18aN2JznScqfyiS+eCq9sx4kYOOj+I3Q==
X-Google-Smtp-Source: AGHT+IHRyVkZ57nzhyTKCltTrLPpMwsHIDQ7uc0ufm1hakxjYl3N48OH2yPl7P6OWGuq8y5vu9wPIRf0jtP4zFgzCA0=
X-Received: by 2002:a05:6830:730d:b0:739:f13a:6f41 with SMTP id
 46e09a7af769-73cf06820a7mr1087123a34.25.1752119117879; Wed, 09 Jul 2025
 20:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704084500.62688-1-cuiyunhui@bytedance.com>
 <DB5U402ARSEO.4H4PE19LGCR7@ventanamicro.com> <CAEEQ3w=V6-d+YSWP=0WMt6UAZexrazq0UQjdyUmS3AnMtkdoKQ@mail.gmail.com>
 <DB6MLPA3BJ75.2U5FP5JSJD2LO@ventanamicro.com> <CAEEQ3wkoy3Jr0vZk=X4U56KYPq3=5t7Wr4RE6uNby3MS5qzh-g@mail.gmail.com>
 <DB7L9ZHZI3AI.36SXWX2SO9OS7@ventanamicro.com>
In-Reply-To: <DB7L9ZHZI3AI.36SXWX2SO9OS7@ventanamicro.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 10 Jul 2025 11:45:06 +0800
X-Gm-Features: Ac12FXyE0pTXhJgf-CmJFYzzVTnilQd8t8nNTo1YCw7wwl6W4gnmmliWfCBZFlE
Message-ID: <CAEEQ3wnaL5X_jXEmbbWFp3jx1Aq=02Gf7kDNBS=wcPyfEq7yBw@mail.gmail.com>
Subject: Re: [External] [PATCH] RISC-V: store percpu offset in CSR_SCRATCH
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: masahiroy@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, andybnac@gmail.com, 
	bjorn@rivosinc.com, cyrilbur@tenstorrent.com, rostedt@goodmis.org, 
	puranjay@kernel.org, ben.dooks@codethink.co.uk, zhangchunyan@iscas.ac.cn, 
	ruanjinjie@huawei.com, jszhang@kernel.org, charlie@rivosinc.com, 
	cleger@rivosinc.com, antonb@tenstorrent.com, ajones@ventanamicro.com, 
	debug@rivosinc.com, haibo1.xu@intel.com, samuel.holland@sifive.com, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linux-riscv <linux-riscv-bounces@lists.infradead.org>, wangziang.ok@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Radim,

On Wed, Jul 9, 2025 at 10:20=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcma=
r@ventanamicro.com> wrote:
>
> 2025-07-09T19:42:26+08:00, yunhui cui <cuiyunhui@bytedance.com>:
> > Bench platform: Spacemit(R) X60
> > No changes:
> > 6.77, 6.791, 6.792, 6.826, 6.784, 6.839, 6.776, 6.733, 6.795, 6.763
> > Geometric mean: 6.786839305
> > Reusing the current scratch:
> > 7.085, 7.09, 7.021, 7.089, 7.068, 7.034, 7.06, 7.062, 7.065, 7.051
> > Geometric mean: 7.062466876
>
> Great results.
>
> > A degradation of approximately 4.06% is observed. The possible cause
> > of the degradation is that the CSR_TVEC register is set every time a
> > kernel/user exception occurs.
>
> I assume the same.
>
> > The following is the patch without percpu optimization, which only
> > tests the overhead of separating exceptions into kernel and user
> > modes.
>
> Is the overhead above with this patch?  And when we then use the
> CSR_SCRATCH for percpu, does it degrade even further?
>
> Thanks.


We can see that the percpu optimization is around 2.5% through the
method of fixing registers, and we can consider that the percpu
optimization can bring a 2.5% gain. Is there no need to add the percpu
optimization logic on the basis of the scratch patch for testing?

Reference: https://lists.riscv.org/g/tech-privileged/message/2485


Thanks,
Yunhui

