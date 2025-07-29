Return-Path: <linux-kernel+bounces-749605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCBFB15072
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10591540846
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921A296147;
	Tue, 29 Jul 2025 15:49:46 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBEF295531
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804185; cv=none; b=AFvfucfY3IMu2y9y1jj/ozb4Iq6QvqIDlDzaBlKfCCE+/qP/xr8QYmNj6S4bCfeYdfbsTnzGjvuKLUo7noe2p0jlnyGPrEmaLN6rUnx5VwwQHTnP78X4I4cYpeY71W9GyOn/sEx1Gz/21E1n8FYZP6ZBdNQ47xH89XELRFjeCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804185; c=relaxed/simple;
	bh=xOEAeeQL3t1RcMvLNfRNpf/bSygqBiYvdQLATWAkt5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcoMEnVaqKcWkqH7NaMIVR+zpMuOuNApd61zDj14LG1XIMmQ6KmhfbAOz0GKuPrl3KtpCo7Fi2pJ/3we9oKqrj2rn65Is39IJhXSGTJltUSDbTj8HffhL0sXNm83zHW1JbBLMInFM0NgCzCWSrw0rZc7roD+G9NJ6mYKNm1IuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-538fafc4935so1480559e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753804182; x=1754408982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wADgSHvwlHUwTHyzEE7Zo53BPHoQdaEMqx/JOShNjmo=;
        b=o+enZJy7AbhRepYWUQPk5Fp2hX+32gyJg6C9igfadCmIF8hcDXJdaRR/m1lmL+FeM6
         HixngBOXCxi2aKt6vtX456I728oOvfQu/sBJU/q+zwOtDPwzIck+HQM1E7hQSFQGQkfd
         M1CCejy5g+J28uvpaVCSSbWBsE8gxwOG8rPaxBCguFIkQ9jKAYQMpJCu3G7Y9ae+eYXZ
         OaB+YZuOUB3rIIgk5tn5cn/dRdEYD2sevVEd/OMbuFMcejyjDvkP4OhwJjmkQAUhXtJr
         DZZVxg07503yLUHBrph4njrn9b36URJ61+KMQ04qZCLy3CEBGtlC6na+j5JyXxfgkl1G
         cmGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgo0EipO/yfaZHS8rZbI0SfeQ42mdofE6fqlvnGyBRpO//4hHnkWuTnsKs3PaBFwPch1jG5NejZnB/NYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqT/QGFxj7wAyhbFS9LQ5LM3TQxkQ0jX1hGzq0TO9e/Q9iHPyl
	8BFl0OthCSS+KH5n7cIr5Jt56FLO/lHQBuBM1IhqzlaZZaTSfxEOUXRmJTP337iB
X-Gm-Gg: ASbGnct0t1PR/+XS1BFSaBndTN2fejbYUYh+f5rJ6imOeOlZibI1wvMc4LCqw8CiMON
	RVyxS3Tx3fVizhDOcANY5a4TqB9gFqexaS2/f3Q88kxhpLC6jIckapUaISxI+NSYb5gWdPDbmD1
	x04UcAhJnXDY7phQnMkIgG0gRTg7QPGl63P1bHP3RUD0uxUvU/W20aZccLOWDFkFkH97tcFvlJ6
	5tjys0mxcjGAYwQ99zx48/Myh7K8Qd/2j/ol1/VVEDxWz61kQ13SxABkNNANpz+JiQ2XS1ffJco
	MH94TMO460OIUVUmPjsEdE9tfMhxSgW8xj/u0qXXBGOvvEVWfKCFJqBgNBffmCreStyrkqWTvHN
	lz3g2FapN0Rkx+/GKkRSEJiuDbMDmLc3TpsfAgyrlesOTjVTQZzJzBF7tuGRv
X-Google-Smtp-Source: AGHT+IHj+f/XGmDhLt0OeFLWEVkw99whovD7MFrADJP5WoecfxfmHc1Wg+aS1vp3bGWvdvdoOUl7vA==
X-Received: by 2002:a05:6122:30ab:b0:534:765a:8c3c with SMTP id 71dfb90a1353d-5391cee5f36mr340235e0c.5.1753804181685;
        Tue, 29 Jul 2025 08:49:41 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-538ec27d0absm1731086e0c.17.2025.07.29.08.49.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 08:49:41 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e9c6b44477so3695429137.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:49:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEhyXlHr9UNCaK/lpi6QMiJaf+/ow6PamMQdvFabieSUJJ0cEaDTNsR0ESK4biffl7pqEOOsrNyzAiDiQ=@vger.kernel.org
X-Received: by 2002:a05:6102:8026:b0:4e5:8eb6:e8dd with SMTP id
 ada2fe7eead31-4fbe7f213c7mr299399137.5.1753804181235; Tue, 29 Jul 2025
 08:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728093412.48065-1-jogidishank503@gmail.com>
 <CAMuHMdUkJrsug-hKkM_f+0xxrPHBQfw_3WB2FhMM=yAYzRn1Eg@mail.gmail.com> <CADorM-9OnP2zbtn6FHp-3NcO8nfnwC_RbzdcHdiUJCPXyMy8ig@mail.gmail.com>
In-Reply-To: <CADorM-9OnP2zbtn6FHp-3NcO8nfnwC_RbzdcHdiUJCPXyMy8ig@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Jul 2025 17:49:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW3JxeLEnbPqc8_Qvpr7mwHhsZoaWwB8QXTMbYRYW7-Aw@mail.gmail.com>
X-Gm-Features: Ac12FXx2zcj8uSpr-DclIbXGTBctpzKN-BF1IK0QUMN4DdI6w1-myOzFZAJSa8k
Message-ID: <CAMuHMdW3JxeLEnbPqc8_Qvpr7mwHhsZoaWwB8QXTMbYRYW7-Aw@mail.gmail.com>
Subject: Re: [PATCH] zorro: fix checkpatch error by avoiding assignment in if-statement.
To: Jogi Dishank <jogidishank503@gmail.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	darshanrathod475@gmail.com, Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"

Hi Jogi,

On Tue, 29 Jul 2025 at 14:10, Jogi Dishank <jogidishank503@gmail.com> wrote:
>
> Hi,
>
> Thank you for the suggestion.
>
> Additionally, the conditional logic is inverted to reduce indentation
> and improve readability, aligning with kernel coding style.

Thanks, but this is not how you send a v2.
Please read Documentation/process/submitting-patches.rst.

> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Unless I am mistaken, Christophe merely pointed out a bug in
your first submission, he did not suggest this patch.

> Signed-off-by: Dishank Jogi <jogidishank503@gmail.com>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

