Return-Path: <linux-kernel+bounces-802329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC29B4511C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1913348116C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A762FF168;
	Fri,  5 Sep 2025 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VqH1H+KC"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7706425C81B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060209; cv=none; b=PR+P0pZR3lcjgTe0QaSfuY80CYXkBmH3KgBiXicwh/Ib58FHnE5J3zfrKtX39uxmt7potbxt5OnE18VVAWbHUyRjvv6WC0hvteoabsO1N9Z/5LJGFLRbFtzMpm56z9J3kaTUedwq4C1m5UI9LEcQx5SNUfvOLZATSfdo0y08ISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060209; c=relaxed/simple;
	bh=r34BaPjjnAxEk0pYZF1gJK7z2l/adNB3vzB+6aApLLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3eii5ftlMZMI+O1uDgq/IHn/qEmlEpOh+Q2BrK5k5+d97qqmkHfeSCsR6oE5RJo0AUK0V6VneAXUkWERFFm/FdfkLBTSRrC+FAktaJmOZjHJujDT1YF9Cxl9DjOcguld5Ppy3nAL72her/rB46w35Hv7ulF7ZSXd1ZvA4cEThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VqH1H+KC; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70dc6d81b87so485466d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757060205; x=1757665005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pmRMEuNmJqUQDrfbifQMhcZYMdkhFlWyXwwtuzWLPlM=;
        b=VqH1H+KCUWU4657PsFvLhiEzB1qE8Kz5Dc0tHJuwxVRlG3AKc1tco7REkHb2AllmsU
         GDaOX8YedV7ETQmapML4qR5fmjrv5FkeodrmTA5FLt7PGQArdFI+howebmZIuatxcZQt
         4IoRmgG0D8pubpRF69bml6Rs6kyk8KDREK9GerWjncrSWLJwfm6RHvXpdNLeFQoMJWUL
         nKqOwQoaBII1A0r2HBlr6MwrIfZnxs+jtTXz+x/HLdnTA2GvAo25Ucao+iDqA0XDTYtH
         FHU/8A9qbWGX2nWFUNeBeeYYk3FAMaaRQbmfF+D5pQbsYq5BkN7bAQV66orOPlVadfSF
         RFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757060205; x=1757665005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmRMEuNmJqUQDrfbifQMhcZYMdkhFlWyXwwtuzWLPlM=;
        b=i04XMuWH9RDx1Tl5BSYMNq3EuAfNgTkBt74C8DIsoefOsenJFOM6GBOdvNR84Nzick
         WnkD3uYgPzFCTXFMmB+gKF759VLByJYzVJBwGn5n96m0BjjpKFXH2Aky6N40106d4kNn
         xrSUNKIDBWu+QZJOk4hn+VVI3MBV4zQR0pbsvYfcO/Cojb4AmIojSJEZQ4ZonYECMgdO
         IXoDRe6ihH8hTa8Yq1ksxN871kN6Ildh5AGxavcddVvOqiALrlWdZyUZMQ35z+4g4Cuv
         +x3UE41ohfIPjvFdIOBEMaz0QOiKWIy9F5T1MWMTLl8D6eRDP+ZinSeUf3wUC2N69VX0
         2mog==
X-Forwarded-Encrypted: i=1; AJvYcCVKN+n0/sqpxlcVLp5plv8l4f10oNJx6VADeDN4+Xe0TTZgkjQjgSD5qXH86xRgcKZeh3pFPtEXuxHdQvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFR8STE2WZmbgbS7NfGilnb6MwJWf420LhickHbkB93WKI6fe
	yXUuCPaRHgWMNsOD8ddex64KmsX1hl6GXDts9p05DyoytuGvp1mrYUpknAbIB6qtMXoo3aCYMiH
	bKdYGwZHmYL8/4+pmKkOwjyKwLVvvRiTZ4kPtNx6DAA==
X-Gm-Gg: ASbGncsugBmkL+oAvLlPvykE9SqF9q06KeZg8X6lsWuQnZlfwy3ZNDtZGx1FWRRzbfC
	1WmgGAjxkujW4ZIrESDer/2QtUWaYsyMH0cqu4aNwyMxiCNb77xfCO9H3zhMnO8MZqSFvKO68Ki
	ykpQVjg+VUsKYm/naMoaTHjiDeCl9/06kwun5Jy03clH+Tl1/Ex9wKuXiTQZiN72Tgoj/o3tyR4
	rRfqxlNocPteH5aHAypFNtetbYSFxpdjx8IcQ==
X-Google-Smtp-Source: AGHT+IG1/H0XgF1Z0mVwgA+Hm/3Z8WnWU7aR5gwqaxhSAw9EmueUjpEcG/rJ6rBmj73ByYwqulnJNifibNyClBj0MK0=
X-Received: by 2002:a05:6214:4405:b0:72f:27de:9443 with SMTP id
 6a1803df08f44-72f27deb20bmr6495506d6.0.1757060205056; Fri, 05 Sep 2025
 01:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905052836.work.425-kees@kernel.org>
In-Reply-To: <20250905052836.work.425-kees@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 5 Sep 2025 10:16:33 +0200
X-Gm-Features: Ac12FXxXBCiJZ6j6Q-_OR5jc0zqm4NYxAPnOlmCg3M0Qu-SVhJpAaiy5I8LGFng
Message-ID: <CADYN=9Kd9w0pAMJJD1jq4RSum5+Xzk04yPZiQxi9tmEBtHPEMA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Test for bit underflow in pcie_set_readrq()
To: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linux Kernel Functional Testing <lkft@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Sept 2025 at 07:28, Kees Cook <kees@kernel.org> wrote:
>
> After commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
> ffs()-family implementations"), which allows GCC's value range tracker
> to see past ffs(), GCC 8 on ARM thinks that it might be possible that
> "ffs(rq) - 8" used here:
>
>         v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>
> could wrap below 0, leading to a very large value, which would be out of
> range for the FIELD_PREP() usage:
>
> drivers/pci/pci.c: In function 'pcie_set_readrq':
> include/linux/compiler_types.h:572:38: error: call to '__compiletime_assert_471' declared with attribute error: FIELD_PREP: value too large for the field
> ...
> drivers/pci/pci.c:5896:6: note: in expansion of macro 'FIELD_PREP'
>   v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>       ^~~~~~~~~~
>
> If the result of the ffs() is bounds checked before being used in
> FIELD_PREP(), the value tracker seems happy again. :)
>
> Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: lkft-triage@lists.linaro.org
> Cc: Linux Regressions <regressions@lists.linux.dev>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Ben Copeland <benjamin.copeland@linaro.org>
> Cc: <lkft-triage@lists.linaro.org>
> Cc: <linux-pci@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> ---
>  drivers/pci/pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cd..005b92e6585e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5932,6 +5932,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  {
>         u16 v;
>         int ret;
> +       unsigned int firstbit;
>         struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>
>         if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
> @@ -5949,7 +5950,10 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>                         rq = mps;
>         }
>
> -       v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> +       firstbit = ffs(rq);
> +       if (firstbit < 8)
> +               return -EINVAL;
> +       v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, firstbit - 8);

Hi Kees,

Thank you for looking into this.

These warnings are not a one time thing.  the later versions of gcc
can figure it
out that firstbit is at least 8 based on the "rq < 128" (i guess), so
we're adding
bogus code.  maybe we should just disable the check for gcc-8.

Maybe something like this:

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 5355f8f806a9..4716025c98c7 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -65,9 +65,20 @@
                BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
                                 _pfx "mask is not constant");          \
                BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
-               BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
-                                ~((_mask) >> __bf_shf(_mask)) &        \
-                                       (0 + (_val)) : 0,               \
+               /* Value validation disabled for gcc < 9 due to
__attribute_const__ issues.
+                */ \
+               BUILD_BUG_ON_MSG(__GNUC__ >= 9 &&
__builtin_constant_p(_val) ?  \
+                                ~((_mask) >> __bf_shf(_mask)) &
         \
+                                       (0 + (_val)) : 0,
         \
                                 _pfx "value too large for the field"); \
                BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                                 __bf_cast_unsigned(_reg, ~0ull),       \

I found similar patterns with ffs and FIELD_PREP here
drivers/dma/uniphier-xdmac.c row 156 and 165
drivers/gpu/drm/i915/display/intel_cursor_regs.h row 17

Cheers,
Anders

