Return-Path: <linux-kernel+bounces-803859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04083B46675
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A603189498E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC522F60C1;
	Fri,  5 Sep 2025 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ3boSeu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AC2DAFDF;
	Fri,  5 Sep 2025 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110487; cv=none; b=FoEvJEHntVC7hgG9aihybZj73q7kgNrM9ghYIrD1/CrmhwG5koQToG7qPIkyZfL3V2ZI1tOwa0/ARCLV+SYh/EimkEQswMQM4KALklD5vN4VqnENt/cl/Huq8jKxNT9zFFYG1LjaIpbd3wZGAmsCi3SjtIR6hlKa/6+pO40VZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110487; c=relaxed/simple;
	bh=M8ULZVGdfoNPKCkr0YbSFZ0232ZRMETp/w0mUxyeEAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HdUqohN2f+JR5J1NrrxkLcXX8hNbufmbrxBxDycaIp+6yUthwYIyfFRrplzsq2VYxwRzvRaiSSju9265JFnKh2rfmspgLTnqwYGrV2PAk6hgZEwcXbWNNPK58OSqYy4aeRAu78uG+pPc6uyvsmObb2QCXSBIjawgUSOg0ygdnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ3boSeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146D1C4CEF1;
	Fri,  5 Sep 2025 22:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757110486;
	bh=M8ULZVGdfoNPKCkr0YbSFZ0232ZRMETp/w0mUxyeEAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qQ3boSeueIpigl6fa71DchJ8VGIKdVFH7+Ui0CWxTf09/nhVmUNSdynhEB9CrTzHG
	 DFEXWcftn82m/wOnPll9xdA1Bf/LGMyVV/o+1pnykAvQyLMcTcgJktBVyhBouhSURZ
	 NyvULPeD9EdxyWfBMmWZuwmtILXvi1rEpzVqyawFV56uFMGxWBVnbi0FUuKqCL4Q3/
	 r24sH5pzDdmxAcvmTVur/nKBw6BMjusU7FP1x0q7aiXnBuXfCS3dM/o0nxISo+6Qkv
	 REUR9oQjjHu7txtnkMiKFtQWD8YM4lgyltKBIH8cTy1UfynvSzcovfV3pjHZYns1bn
	 YhWTLpf3RFSRQ==
Date: Fri, 5 Sep 2025 16:14:43 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
cc: kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>, 
    Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Fix sparse warning in __get_user_error()
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Message-ID: <6bc6fe97-b9e6-03ca-91e9-e61fcd51f3b9@kernel.org>
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com> <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Sep 2025, Alexandre Ghiti wrote:

> We used to assign 0 to x without an appropriate cast which results in
> sparse complaining when x is a pointer:
> 
> >> block/ioctl.c:72:39: sparse: sparse: Using plain integer as NULL pointer
> 
> So fix this by casting 0 to the correct type of x.

Thanks, queued for v6.17-rc fixes.

- Paul

