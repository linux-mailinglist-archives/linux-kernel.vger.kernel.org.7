Return-Path: <linux-kernel+bounces-867393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7152BC027AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEBF1A68517
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EA5338585;
	Thu, 23 Oct 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U9814PnJ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889733509F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237807; cv=none; b=ZQVeIwXzTDuL+/gz5XPVAUzd4Yi4AZYK/McpXeuQA/e2Sgm7uUxhIK+35AztSHB6jTtDy4ES76JL8wysNicFtHk/1DZT8DqnMHlCzt/vh3T0OiJDurU9Wo+yKc94QypnUs/ZQqAOs/Ff8VrXs/fJCBZLgvWuFBIjRXwFGP/3Af8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237807; c=relaxed/simple;
	bh=NlMsuC+hLczA175gI0N66BlYohu8KO4QfilGqXFod1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kti9nCqbFR2x3LiRcocScA68p2myvO3GfB0BXpaGMzAWz9oN+6omnYtZLZEManxZgYENTYmWlE4vKg6+0sGpgnN46PQux+8i7TvEmwBjfe+tP9q+Ke/VY63I49Y3GVR6wnIe+4aKLigNgcHyDWUXTlg9g9FMdCJzaMdHcxV1kqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U9814PnJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b6d53684cfdso244231466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761237804; x=1761842604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WjCSc1ZZpuZRX4G6plj++Kzx3n9wKb7BWAcrh1LIKrQ=;
        b=U9814PnJHfEfriED/f0448pNHpnuk3D1L1dzdH/CYLbfNHsDDz+LvExUb/YUh8+EMZ
         9rqqGu2w1DZdT9GL3BlUxoHFSHQGKFIMl6BOHKvWYo1/sLSb7oRk+XiwbbM9b+Z+Dx6e
         vhAlbL0YCCTlgQkTv0Cfdi/D/JQjPYv2LGGO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237804; x=1761842604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjCSc1ZZpuZRX4G6plj++Kzx3n9wKb7BWAcrh1LIKrQ=;
        b=BL49UyefFq1EckLUGIN1pVPW8yOC6BFGP8ePGTad64tBrpPK9OnZDSTSliN60qmCaV
         QwQhyS0eyx1GGb6YRu43ua33jNRPBTwDs6WjNk9+TZCbK3/m54xf9/4tKIrdCwUtLc7F
         L+0q/78+2lyCAKmGTRNeu56n/jk0ReLBqSS/IcDQn5IhR/4b5JZbm6+cYecA2TqmyQBd
         qaxA5ZS+KRv1jn29lvzWKqWOR813DoIPTqEPS01pH41fGNL/jPuXgv+GovHnp82QCdMx
         Zvv9bTjNbvuqZMLmzEtZ96SNeSkZXSSz3L5gIEKXI15CvI+2hzJge4z+PZhb3lfV8Fqs
         FOqQ==
X-Gm-Message-State: AOJu0Yw2yRjCCP6JC+i+arbBD6kUXsODxq8ltEhgGeuAgf1/atNov7tC
	n38elxfiT2XeLlULwoAKeR733tIPEW4DcLA3cxwXNIEgdFXNOlWHW/ncg/fXLrPnMCaRRCH6EYw
	ItiyBmMc54Q==
X-Gm-Gg: ASbGncvi7oWnZTZ897yH/qiecTF/lujkAjgC4xQr4hJ992Q6zIBf7Fpoe0esH7oBWyY
	8/TFS/nT3Fzwdm99M0w5DPCp7R2NXUVVRfLn+QntQt08TEzkxMhfE6uWrMN4IHWIsHJo8gioq9F
	CLnTismE5YiThQ4+ZJaLaCnJSgqrdu2m6ZnHqI6pd1qsOxesVN03p1rdgu4e7OE9KEfBGQMX2Y5
	MVFjhwlD3AQaL771YwxlovKN0t2nyXYtoY8vHDVFQ+Zzhtw4S0plvjw9WqLcEg3NxkcPDgcVVA/
	NHQNuVhck1lW0T2o1oz9cL9jmYaTPMRAJyWIUsmcTR9A6dUtl0RgjyBus/1UPcHuX9JI+y/96PV
	pPtkvNTHP7zz1Kd6UrVAPkqdSMHCf+yKuZwI3XM8mVIYzLPdyYaqS6yacqxwpALAElx/nVVDqpK
	13Q3vzVSYGLZWT0UbkYJwsPj7IGGMRovVrIA9h64NxOR7G2qHlgPFaUuuln9aWnapmmMRJsTo=
X-Google-Smtp-Source: AGHT+IHqJp+FHz4rn9wbzE4X2C/psIu2QLccwxz8Pa7fIUSn21y6frvVgiRFGtflJBrU0nu5tXx0dg==
X-Received: by 2002:a17:907:3e24:b0:b3b:b839:577b with SMTP id a640c23a62f3a-b6472b5fe70mr3312366066b.12.1761237803638;
        Thu, 23 Oct 2025 09:43:23 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f7b2asm257182466b.18.2025.10.23.09.43.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 09:43:22 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so235934766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:43:22 -0700 (PDT)
X-Received: by 2002:a17:907:72c6:b0:b59:5520:533c with SMTP id
 a640c23a62f3a-b6474940f2fmr2959730466b.40.1761237802092; Thu, 23 Oct 2025
 09:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023124400.3279-1-david.laight.linux@gmail.com>
In-Reply-To: <20251023124400.3279-1-david.laight.linux@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Oct 2025 06:43:05 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiptD8Re=Tr_ymqrpzPp2L053e5XfvrdiPHumc91H3eoQ@mail.gmail.com>
X-Gm-Features: AWmQ_blLyjnab4sqhQvz_Whg9OGLUms5lTpLsUn-GRYv7jz9UAkWfFwdEZevkLk
Message-ID: <CAHk-=wiptD8Re=Tr_ymqrpzPp2L053e5XfvrdiPHumc91H3eoQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] uaccess: Rename masked_user_access to sanitised_user_access
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 02:44, David Laight <david.laight.linux@gmail.com> wrote:
>
> masked_user_access is a bad name and should probably be reserved for
> code that is removing high address bits that the hardware ignores (LAM).

Bah,. I actually think "sanitized" is even worse. It reads badly and
is longer/harder to type.

Proof: I just wrote sanitized with a z without thinking about it,
because it's one of those words that can be spelled both ways, and the
z is the Americanized spelling.

So no. NAK. This is just much worse.

I think "masked" in the sense of "covered" or "hidden" (as opposed to
"mask" in the sense of "bitmask" which is where my original word
choice came from) is a fine word, without those kinds of horrific
issues.

After all, that's where the "bit masking" word actually originally
comes from anyway. We may think of it as a mask of bits, but "mask" is
literally about hiding your face.

If somebody comes up with a better name, that's fine, but 'sanitized'
is absolutely not it.

             Linus

