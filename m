Return-Path: <linux-kernel+bounces-855735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00425BE224A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7267619A4225
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4872E304BDF;
	Thu, 16 Oct 2025 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqpSM0/e"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A92F6572
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603306; cv=none; b=Zg7mVHrHNA3DdQrgEUV8+9QVvR2o/HHRV8NpBvm06b+zvehjemRQpc62NttjJ0sBzGojPSJ627PtSVpf9hoJqSON7hGhnCOKCdPdkDtakhOwVcbeEz8RmXy4J0nPDCoA8fJl+c4ZjFsQbmxBfC9yQuhs1bToCH13JatKETvrtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603306; c=relaxed/simple;
	bh=J07mpHl21TfE9t4lZeUyE3RSzcFd2BOmMRpfQEgFbA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SYAHLj0AfT5dxBPJ4Ppn/t1e4MDpSzOekmP7Xuv4r7qfbooxLMjq+IK8yK/YeR87mzz4Rm5Jvs4GzcqccDAg6NTdypWT6tsHEncm84rvKC9K/xYV5h+yV6M+c17SawxFR57AhH6x7N8xpiMk54CkxVgPSrD5RtwfOYp65NM+Z/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqpSM0/e; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6365fb32d66so443075a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760603303; x=1761208103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNmsng+cg2p1PdPlY0IWVGfCJ8y/Q3JJAW6eqsqnHZs=;
        b=UqpSM0/ecihKg0k2HaFS/vXOoFKmZFtC6xw8cxSOh2c1LdTqRLtKc/i+6WwAiLmpjY
         6lUR7SB0StYuDcYb7VelodXhRpMSd71GNqg0Jn4/qgHY0bt9Xfvisn+EchtRCgWwMeIl
         0WToLe8z2/bK4rJ/MGQNEIE/vIC6NRk5jXO2GJ52XZqNUUU4Ct3mOlIdy37+8+SnFWp6
         gpkegEGilFJSgrpRsuFUcV5zbyzb5/Lab5U36oFASNrDvESJGOTRgJrcO0nbAUF9q5UJ
         E9EjlusI008o8clLgBqmXJG7H5durbDGdmj2MwtyL45VxodWwpBunxcHeKFV9zYnxa6W
         9Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760603303; x=1761208103;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNmsng+cg2p1PdPlY0IWVGfCJ8y/Q3JJAW6eqsqnHZs=;
        b=E5XIHqb3BxjuaFMGsrD7fnMAjze/gWIYWdHYHnNd+YtdqLvWc7qW9Sy10zv9xqgBym
         utS+aOmV3ofKh16cgSkQ+8PX4l7k3DsVfORnkg0rS2CHqyy3vPcOn+4SwVjqSp8SPjng
         niMV19qF+mVYfNOWyqlUUW7bnMeg8rtf/kFjrWlTR20KKeoj7SnxKRq2w/GGEIT1hg0k
         VspslmDPEF2vOcO37QQPlQqJcETb03Eb5SvmkFSHvmOjJoKhfG1/Jyjs+gkQSrlL1CyF
         jqcd6u7IK9S4DnfHvjH9jhTiuULlklKpXuwWkVNZ0EGr3ED8cDktZizCJKPwI2mFhtrP
         4GAA==
X-Forwarded-Encrypted: i=1; AJvYcCV8j0In/WHizCvneVigSjk4/C4kC/kRFhA/Py/Iofqr5Km69Aut4gSYL3OSmT/bMA+8MCnSq3dan5ofuQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQ6KI6eKMol3nVDxC/N7ncodXGgZC35aSmR7AdF2HA8nd7Agw
	iaqThNQmOE89+6UDX3Agn9r/lrOixh+sYJA/aelec9IQtaV0SSkc/a234Mrh8wPGJjIROsSon4S
	vQJJDAVe3DINgsQ==
X-Google-Smtp-Source: AGHT+IGgIfWELGcS8CM792Oeson7+h2PhNJbcALhBReQFlhM1RtE+mvU/D5YUvWFzkPTbgP7ct7PeSdqoiYKbw==
X-Received: from edtq8.prod.google.com ([2002:aa7:cc08:0:b0:636:7d5e:f1f0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:b28:b0:634:6d87:1d28 with SMTP id 4fb4d7f45d1cf-639d5c74a9fmr20973936a12.35.1760603303299;
 Thu, 16 Oct 2025 01:28:23 -0700 (PDT)
Date: Thu, 16 Oct 2025 08:28:22 +0000
In-Reply-To: <z5zeptd2yij7e435u4xgdqsvnqf6hwjkwixajlh3u4nggp6gej@ej743d4adbb3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-l1d-flush-doc-v1-0-f8cefea3f2f2@google.com>
 <20251015-l1d-flush-doc-v1-1-f8cefea3f2f2@google.com> <202510151438.DA62BB421@keescook>
 <z5zeptd2yij7e435u4xgdqsvnqf6hwjkwixajlh3u4nggp6gej@ej743d4adbb3>
X-Mailer: aerc 0.21.0
Message-ID: <DDJLS7DZYDFW.XKPRC42PXW8I@google.com>
Subject: Re: [PATCH 1/2] Documentation: clarify PR_SPEC_L1D_FLUSH
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Brendan Jackman <jackmanb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Balbir Singh <sblbir@amazon.com>, <linux-doc@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed Oct 15, 2025 at 11:42 PM UTC, Josh Poimboeuf wrote:
> On Wed, Oct 15, 2025 at 02:41:18PM -0700, Kees Cook wrote:
>> On Wed, Oct 15, 2025 at 05:02:05PM +0000, Brendan Jackman wrote:
>> > For PR_SPEC_STORE_BYPASS and PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE
>> > means "disable the speculation bug" i.e. "enable the mitigation".
>> > 
>> > For PR_SPEC_L1D_FLUSH, PR_SPEC_DISABLE means "disable the mitigation".
>> > This is not obvious, so document it.
>> 
>> The only thing I can find in Debian Code Search that actually uses
>> PR_SPEC_L1D_FLUSH is stress-ng, and it literally just toggles it before
>> restoring it:
>> https://sources.debian.org/src/stress-ng/0.19.05-1/stress-prctl.c?hl=893#L893
>> 
>> I wonder if we should just fix the prctl to match the existing
>> behaviors?
>
> This feature has existed for almost 5 years, I don't think we can just
> reverse the functionality like that?  There could be proprietary users
> out there (e.g., cloud companies).

Yeah I'm with Josh on this one. I would guess these 3 situations are
about equally likely:

1. Nobody uses this flag for security.

2. People use it, and they are not getting the security properties they
   expect.

3. People do, but they know the meaning of the flag because either they
   read the kernel code (in my experience at Google it's pretty typical
   for security analysts to do this, they are smart and rigorous) or got
   suspicious performance numbers (I've also seen this at Google, IIRC
   this was how we found out about a bug in the Retbleed mitigations).
   Or, it could be the users are working on the same principle as the
   author/reviewers of the patch and they expected the current behaviour
   in the first place.

I think we have to privilege the third case here. Changing the behaviour
is gonna be extremely inconvenient for anyone depending on the current
one (if they even find out about it) so I think we'd have to introduce
a new variant of the API or something. That doesn't seem worth it, I
think the chance of anyone actually adopting the new API is pretty low.

