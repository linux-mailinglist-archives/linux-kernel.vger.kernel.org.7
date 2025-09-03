Return-Path: <linux-kernel+bounces-798384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 103E8B41D25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A43997A9724
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE6F2F49E2;
	Wed,  3 Sep 2025 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jslQm9xS"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9351E2EB86D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899354; cv=none; b=VrJOp48gyP1GFat/wQs7OWbpai5miaW1WtTOcO9vXyGC6hxjozbZQ02WFd1Y9986PNwXhGuvnaZgySkpTqZ4A8lKFi7ELM1LJTrHv8NKYzraWC2bf1PxUcoWjtn7V0QwWOhx5z33ZbcYjrzYRlrCQlETS1/sCXLBTM/4w3tlG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899354; c=relaxed/simple;
	bh=1GuhQU6rmPNaq01MPH+AT+4r/HIb7c4xgp69RvWDw50=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WeD/OcS+8jRqGera2iOyMsbRNYpNeVD5TguoUdIJEDV6fXAm+pWqF8vlcVzOk+IIUfGoLeOOn6LERjGpYgVg+3OJJ81LP+6UYlwpsnaRH50wOt4DFEJh97zC2JrxMvS70Jd81PM2C83Cwbk2B3tCGTjY/cc59NrX5vmYaXJ8v+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jslQm9xS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b04271cfc3eso410671366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756899349; x=1757504149; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aiFX+1bcrG2cJ+aL9MnHcz50DNwLVBnWQmvyParhujo=;
        b=jslQm9xSKgzUmz2pGPMixUnfndgeqkyPq4WJFEhIHdanfrKs0DAh4fZwHeBKb1U3Rf
         EWHN0v0WrMNW8Q7yUrUc7T0b81YS77xnYZilg1EumhYuzf8ek0/NIq8txqOeWU0RhIqM
         U5VpoOwibgTOhOosMEb1fcQOjVVwGz362HJg2dMJlaWydPiAB/Qd4Xr725hpQC7RyxQn
         rdbiPDUiCciDS2lwqOcHPyR+nr+Wag0UotL0H8XptA5ZadZ1tnhopGK50xbOhw8cBGl9
         ZztqW9EpfXjebXDomxad/SGAmcaxFg2hh/Utt+X3oM6TJqIB6SfX3G0+gLtK99U0DmNZ
         7Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756899349; x=1757504149;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aiFX+1bcrG2cJ+aL9MnHcz50DNwLVBnWQmvyParhujo=;
        b=P7ucNZPiIkJaEYGifC0LxH69N8Tlus2CU+8g0unGdpbK/ZeUL+uBwMBBXJAVXhQVwl
         tLj3uUJVL6iaEZQmHNZZxVQ61P9fTrKMOakX+Qaxh/CmK/Cs7S1RmXswyYKyDSm7i5jn
         gZF7Y2HjqkNwsW7QVFszpCYA64m0ZJ59OZQ/9thm0hInIMf1RfigB6zsstDRMh6Goadd
         O6jj7cTQFzqbeOG+tMYiNv4CIUryvE7iqdpPd0sfVq0PkqeAE1GpBrxe9bQD+zIuyrap
         36CYxB5adGdCa2MUwoDH7gfDBr3S3EbbuTqPBCXKQv/8iVpFqP76875xW/C9plb3eo2J
         WFJg==
X-Gm-Message-State: AOJu0YzY876k5fhB5as/ytM2a5hoe9kbdsCGeb4SzFHLsqa3IctIdl+J
	31P1yRxQ+n+unfAP/1leY96ao+4OnCz4lBLShnVdoE4OkEQABDKtBUl+Mj33M7gmGNQSWm5QdvW
	te+GfM+HYmi3aKIUyOe0BmHi24+CPVRetgYLl
X-Gm-Gg: ASbGncv/Tw+P4++7WYnk+BuK9uxYdfwPz0T69g9YG1fo9b0k8h6Y12GMMsqHmtYZ+g9
	ezJ+hb6XM8o9xzM/9EiMAuKBVcVCnW/CzJ1vk38R9M+YQTW9uBgouV0k21w3KlWjtQiENUVi079
	MIXpUPgME8ZaB4KBa9RU2ID8SoG4sv6mLjrGeAtFmzj+MkomPa9uisIgg7VKmfj5bIaHpO6VM0i
	+V9cuggMngqwSHaqnvGjqemLmBgfQ==
X-Google-Smtp-Source: AGHT+IHauT/zoazXdaoY7RPrkk0JuNeFLRaDFb6v6jkHYSTkQsYNaoJjErOhvfO7toPNi2jkmd27XnD5bSxGrvv4hTA=
X-Received: by 2002:a17:906:e86:b0:b04:155a:c139 with SMTP id
 a640c23a62f3a-b04155ac1fdmr970597666b.4.1756899349439; Wed, 03 Sep 2025
 04:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sebastian Ramadan <slay.sebbeh@gmail.com>
Date: Wed, 3 Sep 2025 21:35:35 +1000
X-Gm-Features: Ac12FXymNZdVazZTI8Pws0DlCI8sV_E4pyUYcnUqMEdXyvrMpt53yxu-lvFmckg
Message-ID: <CAPKFLCRwu8ZYGoBOvjFs_YaV3nqy=uRC1wfKmMXd2Q96MpGQdA@mail.gmail.com>
Subject: re: [PATCH bpf-next v3 1/2] bpf: add bpf_strcasecmp kfunc
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

While reviewing the recent patch ([PATCH bpf-next v3 1/2] bpf: add
bpf_strcasecmp kfunc), I noticed a small but important standards
compliance issue regarding the use of tolower() with char variables:

char c1, c2;
// ...
if (ignore_case) {
    c1 = tolower(c1);
    c2 = tolower(c2);
}

According to the ISO C standard, functions and macros in <ctype.h>
(such as tolower()) are only defined for arguments that are either:
1/ Representable as an unsigned char, or
2/ Equal to the special value EOF.

Passing a plain char that contains a negative value (other than EOF)
results in undefined behavior. This can easily go unnoticed in
environments where char defaults to unsigned (such as GCC on x86), but
will break or behave unpredictably on platforms where char is signed.

To ensure portable and defined behavior, it's typically recommended to
cast to unsigned char before passing to tolower():

c1 = tolower((unsigned char)c1);
c2 = tolower((unsigned char)c2);

This ensures compliance with the standard and avoids silent issues
across different toolchains and architectures.

While this may not cause immediate problems in the GNU-C ecosystem,
implicitly relying on compiler-specific behavior can gradually reduce
the kernel's portability. Keeping these cases in check helps maintain
the kernel's long-standing goal of wide platform support.

Thanks for your time, and for the ongoing work toward clean and
portable kernel code.

Regards, Sebastian Ramadan

