Return-Path: <linux-kernel+bounces-856346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 558D1BE3EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 792194F1FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA4A33EB06;
	Thu, 16 Oct 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHAHm+MH"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394F32863A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625218; cv=none; b=uKnWkhSH7f9IfhD7XFv9ap3CDf+wkabChkpCTfXloPsxSPXY7OM7+awc/U+QBoXUdlOadVSaUM+yFqjVqF6CxKFGavRPfj00Smm1iuqmGd2QvLHDCJpQSfJjav/+kpya+swQujte7fsnNLp/DLzyALoENmkC/BL58eKdUCQDIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625218; c=relaxed/simple;
	bh=/Vty/VZwoQHjM/WtE9Ba3K1d2+DTriLL3XuHwwBEKX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nb9DBakJGM2Kl07ddfZkz6iHCSAMlKgxUZuRz8k1KJopqGVRklalm/qx6jAxABfm694QnpYolIcQKYP92a6IjokwDegetFUEkjgvYba9gPlcgdniBErD7XDDuJUPVgF20JQZ7Q5PU4QFBJO7bkewuZZ734Lywkn4votCEb3crJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eHAHm+MH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47113dcc1e0so4597685e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760625215; x=1761230015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OerT8PIYvovG3JfvzUOvfYb1LuI1tWQXWiB0MVhAec=;
        b=eHAHm+MHkgMGCPleU6cN8qCfq+b+2EsbtI2Vfkq2QD3g1/iGTg2NA5JPLRZUSqTKfr
         I5LDe4XXj7QSA6vP8W+lyB1Yo3bQUafzpTCpBK18v/PhsbSYRTXB+ZWG1z/CSWn8BakU
         lil3mNYEDy58C4jMtlo7eak1EWZutY5jmFsa0t5SmO/Rp5p3HrL0WxpCu/NXXq3t2BrU
         c3IWPQXqj15U5Jjjq4DRXL7WX5i377YH7VeyDLjvokhAiwGTghOkCdeXf0Z/t4mNOAyv
         g87uK6DPLhKlg+Vb/nQSIMlS0yHa8RcjHq/OceW4fOKFSJlSfAmZPxEc1lijBkXFSbZy
         pjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760625215; x=1761230015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OerT8PIYvovG3JfvzUOvfYb1LuI1tWQXWiB0MVhAec=;
        b=wUpp6vLPTuZtNCFIp+GJbnaw0h60oejQcr55Tecax0oUx++eR34xg8MkURhWcgYQa4
         VLDcWJm8GQiIsE+OPw4t7kKszBh9VKeP9CSd/gO/xX2Ny16yqI0J8UHk5z5pId0oXi7U
         dZa313O4xvNI1PU6TmE5X4SdTK9YkbaoLk+FiVs2fcDRgI4EXEiQt0/hgADa5RWyqkNM
         L9pRW73RuHsm4g2SiKJ038N9GNZjxoTg3rx4BT1rCh0gGaAbqI5h1JCSUEQB7R53qvJM
         6AxZnBpfQUANGkqAVA05yvXknTAcitJtsQKmiF/De/lkfBa6DKJY4kJy/kMT8on93Cd7
         AW2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWElQrmKKGJE2P03TMP1GY8IamcB7YgvfrgI8Za6avLvIz1xAC2ih3KQtzf0H81A9R9maXAKSFiXcizYvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjg451jjOdyDaJxpxnKaJ9eqZpOlHG0IuTyRfnuD8VPMXheonO
	CuVCAjXkGxBuavQcM1NikKMr8pl1cerY+LVFYoUT07PxJKjz75HHh5StzlV2oy177f8mZB6c02K
	PbTNLB+ziWzBaJA==
X-Google-Smtp-Source: AGHT+IG1D9iZskRW2LQmoQ/pjnUc7uiSk54orVMgHEx+jABWylS429Yjvj0Ve/oOB8JFAVT06N+7AwbeMo5LJg==
X-Received: from wmpy3.prod.google.com ([2002:a05:600c:3403:b0:46e:3422:1fcc])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:870b:b0:471:9da:5252 with SMTP id 5b1f17b1804b1-47117919c1cmr1296945e9.29.1760625214910;
 Thu, 16 Oct 2025 07:33:34 -0700 (PDT)
Date: Thu, 16 Oct 2025 14:33:34 +0000
In-Reply-To: <DS0PR12MB927341C26CE262CDDDB67EAA94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013143444.3999-1-david.kaplan@amd.com> <20251013143444.3999-21-david.kaplan@amd.com>
 <DDJQYGOJ4VTT.20JIC6NWZXUYW@google.com> <DS0PR12MB927341C26CE262CDDDB67EAA94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDJTJTL9GPRK.JPM92T0IHVTK@google.com>
Subject: Re: [RFC PATCH 20/56] x86/bugs: Move bugs.c logic out of .init section
From: Brendan Jackman <jackmanb@google.com>
To: "Kaplan, David" <David.Kaplan@amd.com>, Brendan Jackman <jackmanb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu Oct 16, 2025 at 1:46 PM UTC, David Kaplan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> -----Original Message-----
>> From: Brendan Jackman <jackmanb@google.com>
>> Sent: Thursday, October 16, 2025 7:32 AM
>> To: Kaplan, David <David.Kaplan@amd.com>; Thomas Gleixner
>> <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter Zijlstra
>> <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Pawan Gupta
>> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
>> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
>> <hpa@zytor.com>
>> Cc: Alexander Graf <graf@amazon.com>; Boris Ostrovsky
>> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
>> Subject: Re: [RFC PATCH 20/56] x86/bugs: Move bugs.c logic out of .init section
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On Mon Oct 13, 2025 at 2:34 PM UTC, David Kaplan wrote:
>> > If dynamic mitigations are supported, all the mitigation selection
>> > functions and mitigation choices may change at runtime.  Therefore, none of
>> > the functions may exist in .init and the data must not be read-only.
>>
>> I suppose we should have something akin to
>> __meminit/__init_or_module/__net_init here (like __init, but conditional
>> on Kconfig), so that users with CONFIG_DYNAMIC_MITIGATIONS=n can still
>> get the RAM back?
>
> Yeah, that's an option (maybe like __bugs_init).  Initial feedback I got was just to remove them from .init since they're now sometimes used later, but we could create a separate attribute tag.  Similar for the __ro_after_init ones.

OK, if you'd already thought of it and people didn't want the
maintenance burden, it's definitely not a big deal for me.

