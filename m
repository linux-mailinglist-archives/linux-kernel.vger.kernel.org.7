Return-Path: <linux-kernel+bounces-859873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BE9BEED8B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC5F3B0E6E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532C02253EB;
	Sun, 19 Oct 2025 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmQQsFKL"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41C9217723
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909351; cv=none; b=AqOuQFlZfw4eFNUgFNIPy1hKCycgwcVZEssOKUZRATDNst+WB556g23H2mh0qTBcTsUSDNB8IKcbgegmNhbHm417UG5Avm7j6CyJwZV7RwW9WyfKIRKFDxCuh00xkAd4XTYecoSYg1Ic6MzwL4FXCLAlXR6bMeGj0wLRIfCf6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909351; c=relaxed/simple;
	bh=n0ZFk2h5cOLfIw1uzK5Zqx67icJ+/4pMJI75wAypSKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWjcZvBQehCSFkARNK70loUdB4mMAEqb4Kcuhm4YCfUZG5KBtOMk3jtdJihvQbIxR6bwsFBqb10zyydp9gptCcE8uSCxZvI9UWLsJdItQzN8T2VSMTjxk090DG25iOVKpZj/NYystJ9290gwuZfE4D9jqMocOHN0AkuW0Iwzxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmQQsFKL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso4282977e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909348; x=1761514148; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pZgFs4FqCijykpFkWDu4oRoguWT7PdOtyygPCwJLRbY=;
        b=jmQQsFKLzS3BL/0SDhdu3AltnTwAG1auHVAcsrHYfMQYsgx4Jczp/RHK3V0hTbgdyD
         h2+IUvd49irRXLn88Hal9Hlo82LwspmGT2MoFAnXhPGsgYHvCn9kkuBvVaJf1ipIhzJP
         FHvxSDUx72PTv4oZsz1klWV7AtiRWl9KQPVGqFtao1pTGto7bQJqfJUGGwg2Dl7Y6d6h
         YGX8jwRNPXAXCuXzE049wZvcO3o0O3VldevVqABapAhuapY81bKfxOPe7XonUf+OLYSq
         +6oO4LxNzMGMXY7+jB54imVbzbvuHB8Na3uXjnJF9Z7X2mtz0x9sc9/+wR7q/uML9CGW
         a8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909348; x=1761514148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZgFs4FqCijykpFkWDu4oRoguWT7PdOtyygPCwJLRbY=;
        b=lJSxjgHJAlqAjbQh3dDjatB3c8A0O4Snfb4plvENK9AoYdADdrbt5+Ra/w/y0VZBfB
         MVMFKIHJ0o3HKJIIUh7kBaz0BUmBgjW+9PtMuZAU27FY6dm7lqHxaZQ5M5TprLEa2Jy3
         GCxRXcZ13IDV3VHMCEpMSvNcBhrCleFDSjT6xuHZhVzd/c8x8HFIL8r6QUqf9TN7hFEa
         JGAssaJz95n7Awbyeif9BZmop/7bBe0uK4ljXyzx0aJixn5dEptL9eqS3rzUoCId3Cog
         HPr3zGCztR2ii+Bu5gMp75LLDMMa3iE130l3omoxtknEtE9lqZ/FAtytrYJbJXnb6Vdm
         G5eA==
X-Forwarded-Encrypted: i=1; AJvYcCUmwUTTkem8P30jMqKDhVqyznzl24crVCpTRje2HBTlqvMuLgT32mpCXAKUtewaZHTWncOimOFBNtcNKTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytcO3XOZlquee4/XvuecMu9cqj8sLsHu7Wn1YkFtSjebwv+PiO
	UGO5uSiY8v7uExKTQ+IwtW5YS+M91QjzNMKo0Ow7ynXHpHQ8cSF8AEGx
X-Gm-Gg: ASbGncuijyCPhehJ1pbanTrsWtvW44SRdKFoey6Y/77B9sklZuzCi+/ojV39iVqfRTL
	rpoz+ZhueYtb/c2pHe3KfD60EevcoMIa/0QH0Rfn+s7ThNT9M83HC675x2xvW4EzwZxmpRnQorv
	GyYcxtjnUbbn10JxlG31vT9fO6Pfz0MawshLw6RizYlKR0XShD55EarxNO3NRvX3RWkuZ1yte0b
	G65CsUAuD4jDW+4uXoKMEN3svupCMli5OHXu1A8EoBggjnlZR5USvnE5pICJSqNroGP/Ee2upUl
	uLANDMx1/lrxuwpoRztwMh+TMrK0KVH+fl+/J+tYWtKFmfJWMH4N0yA2zY7rrC/90HdugrDrj+G
	aPfCZ6phYE/B2xxFrr13BAO6Xhxd1NNswH/bh54BKEKhRwz4EY3s+vCEdhVLL710sBMo=
X-Google-Smtp-Source: AGHT+IH+I9jBbkDr97iE8CLeVNtuiq8X8wVyPEdeyjvp5fA2TYxHDV4mbw9+9KOh4C6CfUUvY8XePA==
X-Received: by 2002:a05:6512:2251:b0:57b:fb1d:616e with SMTP id 2adb3069b0e04-591d85661b0mr3583795e87.39.1760909347750;
        Sun, 19 Oct 2025 14:29:07 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def25a51sm1875026e87.107.2025.10.19.14.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 14:29:06 -0700 (PDT)
Date: Mon, 20 Oct 2025 00:29:04 +0300
From: Sergey Matyukevich <geomatsi@gmail.com>
To: Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nam Cao <namcao@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 4/6] riscv: vector: allow to force vector context save
Message-ID: <aPVYIOz8XRZ-737r@curiosity>
References: <20251007115840.2320557-1-geomatsi@gmail.com>
 <20251007115840.2320557-5-geomatsi@gmail.com>
 <CAFTtA3MObvXRHxbULghGcT=ThrBDeFDJzUY7LOhgNnarzpYeGg@mail.gmail.com>
 <CAFTtA3NoOZEMqYD6+vjP=09T15GiThjVy1LeDX0U8CC-4HMKOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFTtA3NoOZEMqYD6+vjP=09T15GiThjVy1LeDX0U8CC-4HMKOA@mail.gmail.com>

On Wed, Oct 15, 2025 at 04:32:05PM -0500, Andy Chiu wrote:
> On Wed, Oct 15, 2025 at 3:18 PM Andy Chiu <andybnac@gmail.com> wrote:
> >
> > On Tue, Oct 7, 2025 at 6:58 AM Sergey Matyukevich <geomatsi@gmail.com> wrote:
> > >
> > > When ptrace updates vector CSR registers for a traced process, the
> > > changes may not be immediately visible to the next ptrace operations
> > > due to vector context switch optimizations.
> > >
> > > The function 'riscv_v_vstate_save' saves context only if mstatus.VS is
> > > 'dirty'. However mstatus.VS of the traced process context may remain
> > > 'clean' between two breakpoints, if no vector instructions were executed
> > > between those two breakpoints. In this case the vector context will not
> > > be saved at the second breakpoint. As a result, the second ptrace may
> > > read stale vector CSR values.
> >
> > IIUC, the second ptrace should not get the stale vector CSR values.
> > The second riscv_vr_get() should be reading from the context memory
> > (vstate), which is updated from the last riscv_vr_set(). The user's
> > vstate should remain the same since last riscv_vr_set(). Could you
> > explain more on how this bug is observed and why only CSRs are
> > affected but not v-regs as well?
> 
> From looking into your test, I can see that you were trying to set an
> invalid configuration to Vetor CSRs and expect vill to be reflected
> upon next read. Yes, this is not happening on the current
> implementation as it was not expecting invalid input from the user,
> which should be taken into consideration. Thanks for spotting the
> case!
> 
> According to the spec, "The use of vtype encodings with LMUL <
> SEWMIN/ELEN is reserved, implementations can set vill if they do not
> support these configurations." This mean the implementation may
> actually support this configuration. If that is the case, I think we
> should not allow this to be configured through the vector ptrace
> interface, which is designed to support 1.0 (and 0.7) specs. That
> means, we should not allow this problematic configuration to pass
> through riscv_vr_set(), reach user space, then the forced save.
> 
> I would opt for validating all CSR configurations in the first place.
> Could you also help enforce checks on other reserved bits as well?

Just to clarify, the suggestion is to drop the TIF_RISCV_V_FORCE_SAVE
entirely and use only careful validation of input parameter in riscv_vr_set,
rather than using both checks. Is that correct?

If that is correct, then I assume we can rely on the simple rule ELEN == XLEN
to validate vsew/vlmul supported combinations. Additionally, reserved vsew
values (see 3.4.1 in spec) should also be rejected.

Thanks,
Sergey

