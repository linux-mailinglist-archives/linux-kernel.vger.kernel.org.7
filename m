Return-Path: <linux-kernel+bounces-741363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB453B0E340
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B17566F40
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCE728031C;
	Tue, 22 Jul 2025 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EANQlSfl"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E537520B81D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207961; cv=none; b=l5cKNQHv8D07YYjIf/w2ZJLRoIkpDoWel/PqGqGg44fOxDW5hep7vWzunUEJ/183ahNZOcjClnFCfgsp9JLrWBF+UVF4QuejbRpgZqBIQRTXq1Q6+M778f3ewZVIeFc2T9UHKXsAo1m0vL9TDvMAWipDUVoPO+rsADPfIvnzuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207961; c=relaxed/simple;
	bh=67Pku3+c2NeuyySmqR1lN0RI6V6rpW8eqkqkN9fw/q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb4E2OvHJYXvY9yMgrG8+oTB9ADrdkvN5MeNWVjVCvhg+YsuX8FIK1DG0mAMX8wO6rkHc8NspRzwHDKVWM+w9h70OzltSJ8u3Mvs6h8aYPhEl7HmEVoL+hDVuqRV5Ozu8OONJ9UqavV6ysBEBQVwP9gVLfWErt95WB0pOTXxA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EANQlSfl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-612a338aed8so8846993a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753207956; x=1753812756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VBGZFJ3kbjo9dI0n0oCeE0hpcWFl6M0zU4XdxWUvP+U=;
        b=EANQlSfls7rcn1FRgqyrATQvTC2OvTut/0iyB0lJG2t2YUaZPxA8PHkkF7m3Pz73oQ
         KGHFMpSWa9RRkSLkZseG/T3J+YwG/8qEntKWuz+dsVwVtF9IKJ6O/Bn6vBLSi9Oc8POn
         3TioijZgZTEpWaZsrX340SafQrMU4Q3x7D9Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753207956; x=1753812756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBGZFJ3kbjo9dI0n0oCeE0hpcWFl6M0zU4XdxWUvP+U=;
        b=SIeOWBz2sMOJkKXU73TqKGISteHtou8U9lWfr2GzvS/4tMI7wpwOfVurTjNkhb3zZD
         6hg1UzNVVnQ2xOGUvzCeBXu1CfwoSxnhBZlsR2BWq/9wrbpyclYipcvcUd9CVLqSzTkQ
         Uq++/7LhmNvc3Ewmbwjb7grlFUQHhjrVgnz3jCM7BzwyFrhW+9YPV+H1nZrl0SdeVi3I
         JxlJzwK7b3ocnHk2eXOSSJBTgME2MTVww47XTSzLCcdoYrExoEIRwMqTD3jbgG98qLKk
         ZZxkPZAAqTzbCf0gVVvRjcn4wwIXx/J6uvj66nuEv3XjlrbOtZxBrfypuSsT/jxENLRp
         amwA==
X-Gm-Message-State: AOJu0YzZtuF49Y8ICoothIW8kw0GAx5soXenGXE4di2wQPSuPWA1pM76
	mfxnBzZk1iCn9LR9J9vimFZpPIwDlUin9S49rRGdqY5rzXGu1Ntdp/XuMVdfP0OUWN0/zgwezQB
	2cYHxL+8=
X-Gm-Gg: ASbGncsurcz4GVFJRRkREiO2oz2bFCM+i27vc4/h3fwAvGEP7GB19mT/3a3iuZYjhjX
	j5FaTpF4uSJn/ez0W6DwgkfNEYk0PPfXMi7WozJ0j5LSOxGNlS0GJH335lCDxX0TL2wfBw0rkQY
	fRuv16u+rjHJc4ZXggWcN3daeOU+BuZsWsHaAf6yLhD+xdXHcUJk8qPBRYwi8tW/0ugD/YJI/d7
	umozYMUCF7wMcQFARw3HWDRSuTfVndisGcXHHmC3L3KWkr/emaXbayrGoO4wS6M82/PxQcCYXB4
	Y7s04kZPPg92HmG7AP3spHVWFaZmgrtEj1wX8TYYVjt6Yjp5Ms7iO7TM1dJhaYFNepUEMOMEXxT
	IKnTN8nQrSpPNCe8/pacTpKVqP5lalTxkIo3gKHtuKIf6imjvsi1v6d8xI6f1MXEaHbnJClp3
X-Google-Smtp-Source: AGHT+IFypL7PuH5Hk4OKgDlSoKCeV2WKY7p1DQnA24n8vSmuFh+RTHF4vDKorWnqAiOVn0il9G0uNQ==
X-Received: by 2002:a17:907:3f93:b0:ade:3dc4:e67f with SMTP id a640c23a62f3a-ae9cdda321emr2493791866b.9.1753207955835;
        Tue, 22 Jul 2025 11:12:35 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf76bfsm908385266b.160.2025.07.22.11.12.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 11:12:35 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so9144888a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:12:34 -0700 (PDT)
X-Received: by 2002:a17:906:ef09:b0:ae0:e123:605f with SMTP id
 a640c23a62f3a-ae9ce0a4611mr2382909766b.39.1753207954651; Tue, 22 Jul 2025
 11:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722152053.343028095@kernel.org> <20250722152157.664260747@kernel.org>
 <CAHk-=wihb6KVgU__zfhdHR=-Mqhp6qaAABdu31CJ2ML6MDj0dw@mail.gmail.com> <20250722130429.7418520b@batman.local.home>
In-Reply-To: <20250722130429.7418520b@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 22 Jul 2025 11:12:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgSradO-F6XGH+fRRoO3wwzWjZ_m7Z+m2aTVPxwPrsog@mail.gmail.com>
X-Gm-Features: Ac12FXw8Msp8bQOIa9FS5M3JcUkZEknhZa0tiohcg9UvPiSIpJJwczeZXsjNy8o
Message-ID: <CAHk-=whgSradO-F6XGH+fRRoO3wwzWjZ_m7Z+m2aTVPxwPrsog@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tracepoints: Add verifier that makes sure all
 defined tracepoints are used
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Jul 2025 at 10:04, Steven Rostedt <rostedt@kernel.org> wrote:
>
> I kept this to verify that the build time worked too, as the runtime
> check is so much simpler and easier to implement.

Honestly, do it for your 8own private verification.

Don't sent out the patch and expect anybody else to care.

The static verification may make sense. Adding code to the kernel just
to then do runtime verification does NOT.

This is not a "criticcal correctness" issue. This is a "help make
people not waste memory pointlessly by having tracepoints that aren't
used"

There is *NO* reason to add kernel code for this. Zero. Nada. None.

               Linus

