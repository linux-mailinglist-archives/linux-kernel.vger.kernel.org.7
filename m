Return-Path: <linux-kernel+bounces-888652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5342C3B909
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F80627C2E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3E3321BC;
	Thu,  6 Nov 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs+iYUl3"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF972E62A6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437243; cv=none; b=VBDnHY/9VAjQgVfTCzluD/dWrk5Govue4qeVYmsF6SWfZtN+XUGHumxqlcnaMTVocA7LH1bMDE0VnmVSPeu5qRM9RNMEoRuDcL0rE6HHPsNgtLR7EMlOQmfCbkKi2eeECP6KGttcSbRyT6jBHN+LDSN2/pqOHoSP19gzjGUG4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437243; c=relaxed/simple;
	bh=AhPAM+k/mbCfFiz/F0PHfPcbmIYBw78Z8GftLMLsgOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ol68tRZ8R2MeycUFOGHrzwdAX5E9Ybal3ntDT1TDoYJXP5/Kj0trLAHfuiDTxSqE9Q7bcJLtIHrKqY+dmw0uTpsY/fz46y8uQ/jrPKHAr3nxAv2rMBAuYZFDJGxwT60CuAr5MC8DyS86LppylJy3TJTRlFxgattGEbk2VoC0JWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hs+iYUl3; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429b72691b4so823651f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762437240; x=1763042040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSE62zCP8M8Uf64VGNcoF8MdlXmdGzIa+kIu5nfKLd4=;
        b=hs+iYUl3uxdn48HF0iYgz0rQGG65LDNm+Dx0axdSsG90TNSIUX7LCj95Rfqe0Y1FpT
         XGNrxlx+YCiJnpfK5LEKKVWNsINPlElKdR0wNGi2DQ+OPNgRNHOfky+DrFc0cqB0Mv4g
         TqaUzSCf5WIPbLyqPWQ/NrULCwhSQuV2geaZGW+QDFq8BRIsJa1cBs5+CVCM15+pPtjo
         F24UuCeV1Z2XYTX6ECTPMYZso9fS7Bz7ki+yNqYr0UgwzOmP2DvJyJHHekS9IzxCgeJx
         Oidj6yfbLqYs80eJ8Qn84iTRIEHEZUbkmrLICKQIwH+HYNjcNvMK33yABvAnYZY1J/Bb
         meuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762437240; x=1763042040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSE62zCP8M8Uf64VGNcoF8MdlXmdGzIa+kIu5nfKLd4=;
        b=fqqvdXnAGoMDb/5IiWTJIgazhTD2KllFXdNHButQFLwxMe6sC9kD0bogmq6X5hlkeB
         M1nXMCVzZzi9KhAT9w/4khh565LxAKqj+X4fvBFsVJhgqBfrHkd4NYOT7ED+vWYecE+x
         RWIR3by4HjhqyK+hw1aFLMRdY7n+cvMFGPym7BSR1zmcDiA2Ab1rT4B5effAUsYzunFV
         j4Pfc8yFaE+jUES7WSMATMd4VOUjQFFQEqVFDetAXeH4tYuxt3wKktjrWhtocsZW8zPu
         J79wKW2+6Zzv4h0xsYSPEuOULXTs0ZWwhkQqLgAq7GvQboT8TS/zNKdSaxkiWgtQ/SzX
         1s5w==
X-Forwarded-Encrypted: i=1; AJvYcCWlizrKVPgBHEtB8KT2FTRhCZrvAGk0ZtNqyK9WlIntWvJCOEjxJBiGvsnK4wAvOvE/fvuMRqJB7QMe800=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy03ub7NakIKVeGa30WbmEE7YE2TMnoA9wMfPyZa0LzzaIt8oLY
	hh+YSTsrRYRyx/9q+oN49U4XuqUESSlh+awVMpCKZYsRT22MDf72aK15EbvQaA==
X-Gm-Gg: ASbGncuALhQBtUFGM8ezjMyUZAlMm13a1p/4KP5cQhCZz7ZEw2Y54+fB4tLsa7t+eEd
	xEaWwx2TUIIpIhHdxqMPyTo+v4Q93gmsWUcQoii1R3V9Y+vLXyFt25+XJ73OWqruTGCcc7eACrd
	R7bVCcN4XrTzJDFMyxyL5EsDNCC12j1uAUXwbZrFSqXgV2WXJo4mde1ljxrJGZBrWKgkyYqFfsO
	zdHuoW+syDA5wLg2mVLX5tNc2Km3T+aV+dTM87K8zE04BoQH0n7abAmE2Y+S1rIyLGDRxAKTZ/C
	TGLrHYvJTP1Igj2O6e049JziXhOJ1OSAborPLrtS/E5ISpXTCbv2s8B5YcnGUA3ZIESKkpNWQFU
	forZgTD0tqpQNMJg+0y6rCeai+nsloSoSU3eXe5Q2LBiGW+QDR1TZ1L3Kk7N6fvcd/We1n5FAnz
	5P8sR4ti+WESHzT6pmSi100EMeSMpwe4mpsp060CjTePLsB1MHEBAR
X-Google-Smtp-Source: AGHT+IE59bq6lBC7TbfcSOn0yh/wIaNNOVWL8lW2tMhLMbEFTHA8APoD/iPj54+AJd6KBZJ2wQ8NLg==
X-Received: by 2002:a05:600c:3e0b:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-4775cdf44a5mr51201495e9.5.1762437240210;
        Thu, 06 Nov 2025 05:54:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4d7f2sm16568475e9.4.2025.11.06.05.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:53:59 -0800 (PST)
Date: Thu, 6 Nov 2025 13:53:56 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, "Andre Almeida" <andrealmeid@igalia.com>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen
 <dave.hansen@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 00/10] powerpc: Implement masked user access
Message-ID: <20251106135356.51721903@pumpkin>
In-Reply-To: <cover.1762427933.git.christophe.leroy@csgroup.eu>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 12:31:18 +0100
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> This is a rebase on top of commit 6ec821f050e2 (tag: core-scoped-uaccess)
> from tip tree.
> 
> Thomas, Peter, could you please take non-powerpc patches (1, 2, 3)
> in tip tree for v6.19, then Maddy will take powerpc patches (4-10)
> into powerpc-next for v6.20.
> 
> Masked user access avoids the address/size verification by access_ok().
> Allthough its main purpose is to skip the speculation in the
> verification of user address and size hence avoid the need of spec
> mitigation, it also has the advantage to reduce the amount of
> instructions needed so it also benefits to platforms that don't
> need speculation mitigation, especially when the size of the copy is
> not know at build time.
...

Any thoughts on doing the same changes to 32bit x86?

I think it just requires that TASK_SIZE_MASK be reduced by 4k and
then the address 'mask' code written.

	David

