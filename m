Return-Path: <linux-kernel+bounces-797011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4820B40AB0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAAA3A46D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C44533EB02;
	Tue,  2 Sep 2025 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHCSgkbF"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D630C37B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830751; cv=none; b=FIEGJNg3+uIAdlWiFGDPD+qo3J+sgXM8yASYRdVlMTpUk+DFfN8sM+SrW3Alh5gEpybL1/UrYTZvOhuIolcw8Kp/Vl9E/N5naSYkNr8PYQqZELACb45+yhclmTsf5S4J8L89XvUTZerlyzx3iERia2bAJ8o/Jsb+4FDdXgTzoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830751; c=relaxed/simple;
	bh=hsW7p2Uvyz1I7BfjIGuq4MTBzhrF2WShjf0Carefykg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBnXh7+6dg92+CqZw4TLJ5oDdiN0gVEEE3yjMa9K4YlWw7fUEmlCdg6rqL87tGeTQvmRTV3Kc50FshVradg6UAuxvNBwdhK9DAF7Z/EUhugN+BZsx/LgnOVAvsozt8mgrNzr6HnAkY+ZDFB2ELxQztVhQ/emi6bEY0NFwLl06Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHCSgkbF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61ed395ba46so53a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756830748; x=1757435548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsW7p2Uvyz1I7BfjIGuq4MTBzhrF2WShjf0Carefykg=;
        b=oHCSgkbFJ2rrISzIg9sb/zq8Xg4Qv1XZ32J+KZyP8RZvafVHc8B/TwDUbDj8WhXGZB
         bBqfmJ09LbtpxvXhSA6+BvxBjgT1473enRyalcEteiKseGTeqfSvlXUuVhbSv9JbpOqu
         KNTfbHDgGVY4PgTgbG37xX+w41GpZ+NX4MQeIelf+amjQDHh0wZpP/+7/X2/fHPXR/nM
         EiQT9rr0Im1tC2dTijKwRoMrFo4HyimVD/rmxNLLKC/OLNa5OlLw1Ilqg4VuIlu37cGq
         Ep7hd39fRqpLqSY7aPltBfGmcbYSZeZnhmU6f+9222cntIRKOjW+nAK0jTA5ctrORvM5
         Fklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756830748; x=1757435548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsW7p2Uvyz1I7BfjIGuq4MTBzhrF2WShjf0Carefykg=;
        b=uQCsJYrbsEQ72wBshcK/QnMuBfvTLKGuBKiWgC3jcGNARqAIRzpd4vpqFhxYws2bce
         IMGGoAqL5AsQRRrvX/WYGiLuII1lKFhDAfMFEuCJpyPBrWGc8QqRRA/QeHgdrKwMnobO
         9IC8Bl0MNecqi2WWFigQWqA/f1SiLzDPfHJTIgwjPSAmg+Ns0izENL9Fcq2HLxrI3K/k
         GUvAG9kiGDFXRfqdsZIiHZPCqkRfVTCOKmCFnqzC+8OeMdSFMK+8jPaXd2LMkfPuoEPv
         rpycdjUC9lmj1D9lqym8oEfGGKjfuEp0iJd01mSb+9BCKSPRgXt9u2QhSlZ0m4MJO7QI
         Q0Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWvTuCg+3LRwJEix7rFGqEWHszYBIbRfwg+dehM8tnS57C6HeQ5o+Gi4Txkh9+QxYXVZg+v1oSL16YHhrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIfSTg9r+EPdmk/ZjbK+TmoCbzFLJ4x+/9svIUyoLIGmRfGsP
	c9F4wwuYlNmkkZei+4FiIF051VCbWDy694sQ/c5OH58q85X14SiN8wWy0+GQWwomMc+nNsKedSa
	wOYcolXHP0Wzs3AW59LUhIZisfaVrIs0ZWcgqsqG/
X-Gm-Gg: ASbGnctrCkMZgxWjIZ20cqLwmB9nHymGLKKo9ugGWdIAqwVLmbE8yINLCfp5X9CW8eq
	qHOzL+4msDhZIDvNr7x6O1+TbqCQbAUDqe0L7MxUEnM+/jXI2mBIJkk5WPbbX2fkKTHcu15XDZu
	WVWUdfmcxHy9XKaY65ycqx3FE2kyw64udFa4kmSWM0K5K1ptuS1DQZRpyInPDnis7j3SBoOPQhP
	cDyXB3Rg1N8G1+A8aCvgwEfJQjsXbhP7f10SYRlNmUQDvdfJr9HaZfBXGtz0WM=
X-Google-Smtp-Source: AGHT+IG5nuHKIxDgzjc2IG2vJz0lPVJszmpFhp/FyF1ix0dDLy0FE8hycNG4YX3ZSuTvGWwKRisG41UI+Rfm6oT7q7Y=
X-Received: by 2002:aa7:da99:0:b0:61e:c9ff:4c77 with SMTP id
 4fb4d7f45d1cf-61ec9ff4fdcmr65520a12.5.1756830747879; Tue, 02 Sep 2025
 09:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226030129.530345-1-riel@surriel.com> <20250226030129.530345-2-riel@surriel.com>
 <aLcQ3UCXXNcByW1O@gcabiddu-mobl.ger.corp.intel.com>
In-Reply-To: <aLcQ3UCXXNcByW1O@gcabiddu-mobl.ger.corp.intel.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 2 Sep 2025 18:31:49 +0200
X-Gm-Features: Ac12FXzMWTBH_CWk_Rh7cxiHroX4fRD_rpNfwnRzz9Z2Q-oOvClTv0lTunEwjto
Message-ID: <CAG48ez2ck2QaxZ6G1Qrp9p0brFecrnf+KRc7Uk8c9kMJqSOswg@mail.gmail.com>
Subject: Re: [BUG] x86/mm: regression after 4a02ed8e1cc3
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	bp@alien8.de, peterz@infradead.org, dave.hansen@linux.intel.com, 
	zhengqi.arch@bytedance.com, nadav.amit@gmail.com, thomas.lendacky@amd.com, 
	kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	jackmanb@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com, 
	Manali.Shukla@amd.com, mingo@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	baolu.lu@intel.com, david.guckian@intel.com, damian.muszynski@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 5:44=E2=80=AFPM Giovanni Cabiddu
<giovanni.cabiddu@intel.com> wrote:
> On Tue, Feb 25, 2025 at 10:00:36PM -0500, Rik van Riel wrote:
> > Reduce code duplication by consolidating the decision point
> > for whether to do individual invalidations or a full flush
> > inside get_flush_tlb_info.
> >
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> > Tested-by: Michael Kelley <mhklinux@outlook.com>
> > Acked-by: Dave Hansen <dave.hansen@intel.com>
> > Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> > ---
> After 4a02ed8e1cc3 ("x86/mm: Consolidate full flush threshold
> decision"), we've seen data corruption in DMAd buffers when testing SVA.

If it's not too much effort, you could try to see whether bumping
/sys/kernel/debug/x86/tlb_single_page_flush_ceiling to some relatively
large value (maybe something like 262144, which is 512*512) causes you
to see the same kind of issue before commit 4a02ed8e1cc3. (Note that
increasing tlb_single_page_flush_ceiling costs performance, and
putting an overly big value in there will probably make the system
completely unresponsive.)

