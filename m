Return-Path: <linux-kernel+bounces-872056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D5C0F373
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BDD426CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F119730BF66;
	Mon, 27 Oct 2025 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FCiAbTRk"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4192D63F2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580935; cv=none; b=DvvARPh+liOFqAOS4GgYx1Ckvj2rV/nRTCKNnTavdNIEProGQ0GY3NGQYfd55x6ILSM8E6xwccOLnyku4BQNlbrx3suqfe0U8+Zs1P0TMNCTKdW5YdmjglQNrnmPXz3D6Veex0qk4FfjvS90/eg8De1zvD2fACxrp/jZuPjoAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580935; c=relaxed/simple;
	bh=3vakKTarVQ1LmVyja0G1VxJygmwKNqNAyvUgHSG/kHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7GqyDGabSACi+vNQbCBoYG47UdFzrMf7cHUb7e3NnuJXHU0cdmbWySARPhbdSl2CKiSO5Sr5DvPxnnNzrbOTXANjzuEiwHIFb2j7i7Qyo6L74EiYtgGXrq0qTdjbXJ7bBq+mPcyd9siedSrTldWJtFjSi/OHPLnTUFehvilH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FCiAbTRk; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso6264684e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761580930; x=1762185730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lyo3P6jUrO11oV/07r7VEk3+sHuM/zfcTZIIBqJLkxg=;
        b=FCiAbTRkKR7K7Netno9M+9dcRlZjGVPq2WutfmMcy6p5JvMXIgZ4+Al9NkOcgE1nmH
         F/br7pwfnkbN5T7Yg/vTVMwCAzgwq4e2AtxiOoNnyDNREkqaPok+tBAOQNx6mPJQI8WT
         AhwTBzAG0KwNQBE050XdKNhFoSCPaMhyoFr9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580930; x=1762185730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lyo3P6jUrO11oV/07r7VEk3+sHuM/zfcTZIIBqJLkxg=;
        b=PKi4Pvvya2WoWVoh92l2X1J6DBco27PerUIlo2lGHQx3qSagU7VW4heX8WhNqb83Ad
         C0OSVis3pS8abYxfoVEb13aE5ejmbaR4TlGjCoGzKOIRbIFowebPUSEHecmgdXngYuxB
         MreiIzLHrtzbCmXZeJXIvfhEFTnwtYf5Sk1Fqlksy3SJfM56f9ePMBHQlkbMYOMRHAO+
         r/EA0IJNsMni6k7mbhH8IMAOoJJYlRIfFr4/FwNIUneeFWjZrI8xeNH6ByEaewmnSB/J
         pzqnNGf9Zn29pzXtgcD4SUhHwkWM+5vClzQ5ppfcmmnqOKKKKnWRQ3LFo9GF4ffg5Kgm
         PE5w==
X-Gm-Message-State: AOJu0YwV/cLIQWRFXmAWusV66dQEQEyDvhMigibYYQ+GHUkt/oWdTXHv
	3FVFC5PmLoIRUTEP1BgV0h0H9Qi78ITSJwb3vVMNv3CTv+gpL9TuN4nSzu0CGsiz4mJ611sbeIJ
	FNa2xILM=
X-Gm-Gg: ASbGncvsZ5ZBCzE4/kbGYoj06cp0IBnGwZX8ickVGAOcjwi57xLodvR0XRf8YUkpFuW
	bhTYnx05O6KJmdXEWC9FcxLuK+L5kdSnb+/UQBacnH50vnztBivNF+r/VFP6XLOQ92jYaR9UqSA
	7XA2Zqcq+0XwcFGwUv9sqbPxpVQLJsUmdvVjA9caKgSD51qIXJJHXT+8CiijI2oO0koj9S+dK5/
	Fzawx29i6f9IxIVbZnEmIaBu35al5cDALAUfGpfxqrWVj0C+kEEjlFZOLuGsWsaVw3ScK/gIBs6
	9u47iM9zm8AkUzQ9wTgusYDe2mAkYHj3qNFM4fJTpjxo72AxbzatUMwna1fo/NKCs+nljqMSOLv
	nowb1ifG8Qe6HHahAYw+auojcTE9R/LGMX0Jwj6c/ISg2KwaBbc+VzTpdzRrkeo1FcmCRk4tsYd
	Wu+gLSFVqqgAJdYWbLIF2jJ0f5mzASev90XvV5Y8cgCTXVNP/55PvALE1nyrPW
X-Google-Smtp-Source: AGHT+IHTxm7o6s8+qVcTNdIAeIrEaVoswkdbpS1PpV43DvkedxQyS8UiDTTan2HmKaw1jR25cvzcIg==
X-Received: by 2002:a05:6512:3ca6:b0:591:ec83:3183 with SMTP id 2adb3069b0e04-5930e9e1168mr138123e87.57.1761580929850;
        Mon, 27 Oct 2025 09:02:09 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f50996sm2371501e87.36.2025.10.27.09.02.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:02:09 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso6264636e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:02:09 -0700 (PDT)
X-Received: by 2002:a05:6402:4412:b0:628:b619:49bd with SMTP id
 4fb4d7f45d1cf-63ed84db9e2mr369134a12.25.1761580437926; Mon, 27 Oct 2025
 08:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027083700.573016505@linutronix.de>
In-Reply-To: <20251027083700.573016505@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 08:53:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZ0RdDzpafUUduCn3gOVX3a=ZmGOw7wu1s-jqe8KypDA@mail.gmail.com>
X-Gm-Features: AWmQ_blZNXFTqWGx07mPO-qNDyYJc9sRx0MxijvPg_spVplnaBKcigb1OKRcACM
Message-ID: <CAHk-=wiZ0RdDzpafUUduCn3gOVX3a=ZmGOw7wu1s-jqe8KypDA@mail.gmail.com>
Subject: Re: [patch V5 00/12] uaccess: Provide and use scopes for user access
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 01:43, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> This is a follow up on the V4 feedback:

This series looks all sane to me, and I think the naming etc now all
makes perfect sense.

                  Linus

