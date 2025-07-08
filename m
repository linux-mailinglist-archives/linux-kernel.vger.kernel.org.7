Return-Path: <linux-kernel+bounces-721372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21A0AFC84C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A597AF334
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAED241CBA;
	Tue,  8 Jul 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="arZRCAeW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qU4A+HRM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F31268683
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970342; cv=none; b=uj690YJZUOf3dFKwpusVFBc4SeuexIsYuUDK/GTBzm2RZ//cDXALMABlRbvuz25J8XaV+S4N5MI/euZWlm2c9dW/pL17HRimJRqsJtvpNTi7lxuaHrVIB32/DN7xlDlBO8RAu9XJPFp4ZE8y7hzymCx3fpzgr9uWF7swd4rpZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970342; c=relaxed/simple;
	bh=uI87pg5WcASFWD0K32gMteBkyUzucAaePK9YFfv8YtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtwMt43M99L4B6OlFhfKdXMFk83XGrhIF89vu+M5hBecmjgYfP7EGvgb2ydXK4B8dFJT3ZvJsi7wEHQdFXDrYBIbf5oxB5PhsKSBFwsnzY7ntLIR6ZtB7NJ4myJ71W2S71Nr9r/AD6MlBpoT2/aZYCu6Ncv3v1oYW5Oh4mUfV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=arZRCAeW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qU4A+HRM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Jul 2025 12:25:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751970338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mrZZuWaHaXVZ4tU14vD0jFwEhA7UyuVBekyaX6/jSvQ=;
	b=arZRCAeWw4M0tWg+Jv2ndJMHzY8loL+3L+xj7PSSU9OdKuA6ViYhAw/7UlQAs+TH2mOWwZ
	fUCMdcrQkSKXtCY5zMIL+gadeIxglMe7LfXqm9GN+gSRvJGqjIS0PBETAGMRVMghQbBiaB
	uZLxR3cOAngVQbQY0Lf+cL0EBnL5qcZeiI8mj6tSBzkhPMgZVZz0+2O0sl1WbzCNoWOlE0
	A1ZOPrxO1Nna+DAbKMw0OdV+I8sZANeetQqIJokP/DlJlrw0mlyLDQuQk8d4BjQ8Kej3Ee
	gK0BsdO/FSWo5hjqmxunZvuCQnmIVLdVsZR69JG28BsONGkEobGnQu0Lqelm1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751970338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mrZZuWaHaXVZ4tU14vD0jFwEhA7UyuVBekyaX6/jSvQ=;
	b=qU4A+HRMxnXbegaEoeOrkeKk7TR725nLMk8ItxqFSKNkBPROlWCShUsoKrjWvD64mui6Se
	EJwnKQR3YnQdZKCA==
From: Nam Cao <namcao@linutronix.de>
To: patchwork-bot+linux-riscv@kernel.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] riscv: kprobes: Clean up instruction simulation
Message-ID: <20250708102537.VovauOQC@linutronix.de>
References: <cover.1747215274.git.namcao@linutronix.de>
 <174904758698.2309006.9940004806769596353.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174904758698.2309006.9940004806769596353.git-patchwork-notify@kernel.org>

On Wed, Jun 04, 2025 at 02:33:06PM +0000, patchwork-bot+linux-riscv@kernel.org wrote:
> Hello:
> 
> This series was applied to riscv/linux.git (for-next)
> by Alexandre Ghiti <alexghiti@rivosinc.com>:
> 
> On Wed, 14 May 2025 11:38:39 +0200 you wrote:
> > Hi,
> > 
> > There is some instruction-processing code in kprobes simulate code. These
> > code should be insn.h. In fact, most of them is duplicating insn.h.
> > 
> > This series remove the duplicated bits and make use of macros already
> > defined in insn.h. The non-duplicated bits are moved into insn.h.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [v2,01/11] riscv: kprobes: Move branch_rs2_idx to insn.h
>     https://git.kernel.org/riscv/c/d29656bab74c
>   - [v2,02/11] riscv: kprobes: Move branch_funct3 to insn.h
>     https://git.kernel.org/riscv/c/da6de46c2eed
>   - [v2,03/11] riscv: kprobes: Remove duplication of RV_EXTRACT_JTYPE_IMM
>     https://git.kernel.org/riscv/c/6d47d903b18f
>   - [v2,04/11] riscv: kprobes: Remove duplication of RV_EXTRACT_RS1_REG
>     https://git.kernel.org/riscv/c/5cefc323f32a
>   - [v2,05/11] riscv: kprobes: Remove duplication of RV_EXTRACT_BTYPE_IMM
>     https://git.kernel.org/riscv/c/a285674909ae
>   - [v2,06/11] riscv: kproves: Remove duplication of RVC_EXTRACT_JTYPE_IMM
>     https://git.kernel.org/riscv/c/c7196c136e29
>   - [v2,07/11] riscv: kprobes: Remove duplication of RVC_EXTRACT_C2_RS1_REG
>     https://git.kernel.org/riscv/c/768007ca3fe8
>   - [v2,08/11] riscv: kprobes: Remove duplication of RVC_EXTRACT_BTYPE_IMM
>     https://git.kernel.org/riscv/c/f2c715fff676
>   - [v2,09/11] riscv: kprobes: Remove duplication of RV_EXTRACT_RD_REG
>     https://git.kernel.org/riscv/c/284ca2a100de
>   - [v2,10/11] riscv: kprobes: Remove duplication of RV_EXTRACT_UTYPE_IMM
>     https://git.kernel.org/riscv/c/a60c2933ec74
>   - [v2,11/11] riscv: kprobes: Remove duplication of RV_EXTRACT_ITYPE_IMM
>     https://git.kernel.org/riscv/c/ee4c45f5cbeb

This series was dropped from 6.16 due to conflict. Can it be re-applied? It
applies cleanly to riscv/for-next.

The same story for:
https://lore.kernel.org/linux-riscv/174904758974.2309006.8809303189389627595.git-patchwork-notify@kernel.org/

Best regards,
Nam

