Return-Path: <linux-kernel+bounces-856184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D919BE3607
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B737919C336E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D22E36F2;
	Thu, 16 Oct 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AH/c2ej0"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB50841AAC
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617902; cv=none; b=NILSTEp8AL8haHAFCLoVkYD/3ANtBowoeeEN02icmdYVEkWHAaKXuqkPFRWaHcLfc3AmH3c0BSyYtm+4zx1Ot1mjjumHEWpdVIv0ylOIZc/9Tf71fddQrPfUc8BIDSHKuqKbq1OUo6gyzbfN03g44aPlMX+48TuSM04t3ySDygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617902; c=relaxed/simple;
	bh=1o2HzLTinLWTQGf7WMQDBld46QU21f6J+1Y+XMRRcUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ji+CCsV3cenhYgluNaYF+r/bwR2eYSVODT7RZO1YpdgnPiADV6JIaMEiHcGB3pSuE6nZTKMLAAnAWnm60zvlFkfKC9pDRjZsnZ1gF06dM9nyxQRrf4zsKMAO8yKi8MxB4husLlz2yQR92l2EG5DmEzqO2+l2H5TEV7wj8KFxaPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AH/c2ej0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-470fcde7fedso5019815e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760617899; x=1761222699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKHiz1CMmypxPXYx54DCLlmWTpjtJ4WBK9EmUhjhwWY=;
        b=AH/c2ej0MyngNd3xRwHlrkrzuBMg6epWCmn0qFIQTslZXOnoHqVZPCgMrEiafN5Ovs
         zUWZceqTFelJR1glGgiVJ4v3YCtkyhvAoVc4RnmmWTMb0IkDTNnmj5U6o8uaHWw50Y6p
         UPZClaajZHqFQ6vONgR1yvClUXROy8DfoENWLQku1Rz02cYOE39OnQ/i/SS6b0pifq/N
         U3pw98GsrhyKpzgMXtQJczluesI+gfFEfYbB/KNuc28r0J0oI+zzhR+s0vfEiKE4kp15
         MLx2Xiop6buKHxA8AktMiOBlSCIXPGwj+GMrceccXFZw7xJ/BYS4tvS+Tp649M7SnDeq
         2w7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760617899; x=1761222699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKHiz1CMmypxPXYx54DCLlmWTpjtJ4WBK9EmUhjhwWY=;
        b=uRoBU2r55gBMIP0lgaVrfpulKX/xC5Zutpp7A2CunfuFXYVleSOmzQsdA1sHzQUt/q
         60/m9w+hFv2Oa4+8nIK+OXo4cDRGgxq++teXlCkTao13fdydI+shS54ktzbnzytAGY8V
         EnC3s5Cg/wd/7bX8iunYPUPiokRXD5n+Q0+zL18b2ntvE4t4qPhauPqHXD9aVtL1va2O
         K3QGnLQwRJYxl1u3qhFLTP8qT2wjSg5OGFaxcTLbHSIMhGhi2BaLSd3NP+6KKC2U1m0e
         BjA2OycWhIh+oklxCKgvTZRD6nzaa5ECl9D0BXFL2/HTzTn2Suj+RZofTLZyeX+6d9UR
         kYtw==
X-Forwarded-Encrypted: i=1; AJvYcCXnxotv95/FkmdnNxoo2Ocv1lyB6yblVXZNeJ0urJp7Ik0KHcstUkowior7IMGGxBs3lG9/RU/Srj0TSTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3esPKASfWVx4qBmGFU+PofA1+9RvzukvtD9JX3onWvZRFKr04
	/0HU16t9hF/krXvkhrw5gB56Wx5T0QpbQczvYoLbwZUcpkFkesJYPYTdpDrDXdHIzlYk0VDY1sT
	WNDV4M+i7Sm9B/g==
X-Google-Smtp-Source: AGHT+IGLR+LJROog43lW+Eb9EAEjRpzsxUO5Vp8hMZLieXCgQu6CvNMlc/B5PKmDaBrf+EI5qIAYMkzJ7UiShQ==
X-Received: from wmbgz11.prod.google.com ([2002:a05:600c:888b:b0:46f:aa50:d705])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e8f:b0:471:350:f7b8 with SMTP id 5b1f17b1804b1-4710350fab4mr36786375e9.20.1760617899219;
 Thu, 16 Oct 2025 05:31:39 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:31:38 +0000
In-Reply-To: <20251013143444.3999-21-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013143444.3999-1-david.kaplan@amd.com> <20251013143444.3999-21-david.kaplan@amd.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDJQYGOJ4VTT.20JIC6NWZXUYW@google.com>
Subject: Re: [RFC PATCH 20/56] x86/bugs: Move bugs.c logic out of .init section
From: Brendan Jackman <jackmanb@google.com>
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon Oct 13, 2025 at 2:34 PM UTC, David Kaplan wrote:
> If dynamic mitigations are supported, all the mitigation selection
> functions and mitigation choices may change at runtime.  Therefore, none of
> the functions may exist in .init and the data must not be read-only.

I suppose we should have something akin to
__meminit/__init_or_module/__net_init here (like __init, but conditional
on Kconfig), so that users with CONFIG_DYNAMIC_MITIGATIONS=n can still
get the RAM back?

