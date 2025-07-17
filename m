Return-Path: <linux-kernel+bounces-735654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F9B09222
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBE35A1060
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A0F2FA63E;
	Thu, 17 Jul 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/sS8r++"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C112F85F9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770759; cv=none; b=qcqiq5owfCcihMrlA4F/pOMrkOrMTb+yFQqDQ5ZqLC6Sw6QR40orYFG4RBq9ga8GptHdEbfOGTL1LzbxjxYjviDlOH0cdrcKYk0VavK5egkw7YpKhARc8GeRjCDJDeEB0LoI5qIXQUXV+1LuNjl6ua6vXmIztBRGcQ8JPvBZJV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770759; c=relaxed/simple;
	bh=iRnWqNpzFeM5Zf6BqsRpXhJqEgg8Z8aFyrLB8L1gRTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVfFfLBhtUTRkzBo7wZg9wTnaZblKfNn+hwzll26SYx5oU6qDmfA6EfWvm21M9+Yo/Q8mcKe2r3RKvm2AQ3OX2O4f17na/yzQOJu0sxMJSarmwsuUeMPpBdD7qJ9g9uNWJhHIgfspuGV/qayCFiqHR9L42cVy6xs2eqVeMSUgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/sS8r++; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23dd9ae5aacso1255ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752770757; x=1753375557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKUJNmP0H+2EOEC7uEp9wCLLSrzA1vzqL1Sr2tNFz6M=;
        b=Q/sS8r++LCVUFx2WJrZ8QihSRMg5y4xu/Iy11Jf/YqfOawH1ekxr2Er3ZOQ4TcCZ+A
         ws47YfQJL4AUX7kjiYZs3hw1g0e9kKn7oUF2gCROG8XaJMFDr/abaCekKueKJ4VolCRf
         qwr4bNpluu/DAZDuAWQGeG+SEaGqg8Q5/4Pu7Rqiz9QD63dFAI9nUhu2oK5nJUqrTQxz
         14yqIMrbSZ/OE7XMIeHUnyUMSvT6oyAqbIvbjiXrV30sCybkL84pyFBjuBUUJYCVebK7
         rXzvhd2+kUTrk7+inDRSJJbU0pRuqV4zK68hRB9UnLX+SUPisHGYjdO+DkqOTXm9Bk8q
         dCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770757; x=1753375557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKUJNmP0H+2EOEC7uEp9wCLLSrzA1vzqL1Sr2tNFz6M=;
        b=H2e4yc0tr0Sd8BTiSa6bk3mO/wzwLe68UqUj+qtY1evD8xi1q2JeJsxx/5+mXpqkSz
         1u0GO/BDsduUuh43vZ8oHO5X9SvD/cwP0lvtNOrOrWrN+Uwrvv9e/vL1K+rOuxmX7Quw
         g44fbaeOu2P25Hc0J0LToEZ3w6VDk/huI6abc4CIpeZcGMHN/rzEcqlVSWfdBCtKvXlx
         0045dbqLRDV8nHu6vtG4dgm+CX71xxO5I858JrB2rcpB13KhC5qtho8v3T/exx+HdGw6
         PeMNMB7z+WIjGnlf5uY3+0FCYGn6EnVjH/Ny2CbCK3www4ULamZCYHGQcPA4SZtgXmj/
         ONOA==
X-Forwarded-Encrypted: i=1; AJvYcCX3dZE0FCSMWkAp1cwF5NBhDTKsVA9nK+sYOcOtrrTkzeE5D4DjhGkZwc76yOt7XmgW4gSsmVJamggq2Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwGhQX7FSDuEQVgkqMnk4PFfGKAEqjuG8AlPngKLT8cONTb1w
	n3I2/vDe61iiNJBDZqpGP1RCw8xO5WSSIoRcoHy+iOGybPGZ61HHXg8q4Pfm4tF42Me6iVab7SI
	8OPW2uo/MqXCsGQlTfjSDdhP5ErH9z76ucZOIZ3GA
X-Gm-Gg: ASbGnctQuv+nkVLgjQp76rXQUMAK7NYJ9ZVVxc/8ld/jb5QI/BrHXLK6jBaAX/jn0Oi
	3vk7BrZ4rRI0S9DjXc/dqIfwzlUSwxRCfwF0kBsDf988+cfsc42EYYy73qGr6qvhMNDiGtWwyXd
	6KlSZnOuP2i1RbhR4PgVQRb3HSCoTuSYfDm4YEU/HlbEH2++TbPZdcC0/yz3dOeVqViJH7OA+rv
	K9zqG1og6ITpig=
X-Google-Smtp-Source: AGHT+IF/jbc5KsIrIk4t259Eq/zkKG3YR3wGUxeaP9wSJo62CP4cjrCT1LbXx3KWXrxV/ZX4TXAsZ+zA+Z6VyzKLOXc=
X-Received: by 2002:a17:902:d486:b0:23d:eb0f:f49 with SMTP id
 d9443c01a7336-23e392b9d79mr277515ad.14.1752770757077; Thu, 17 Jul 2025
 09:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085300.work.146-kees@kernel.org>
In-Reply-To: <20250717085300.work.146-kees@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 17 Jul 2025 09:45:19 -0700
X-Gm-Features: Ac12FXxFBLO3F6u3hRZZBsSiDUycM_ZS3G7VWFf1ItHH-mMCSDv03W4t2NQH_00
Message-ID: <CABCJKucfFyVqarstWRCRMf1DbvM7-SajkxAphsH-X8MgSPPN8A@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: Add __kcfi_salt
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Thu, Jul 17, 2025 at 1:54=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> +/*
> + * This tries to call an indirect function with a mismatched hash salt.
> + */
> +static void lkdtm_CFI_FORWARD_SALT(void)
> +{
> +       /*
> +        * Matches lkdtm_increment_void()'s and lkdtm_increment_void_agai=
n()'s
> +        * prototypes, but they have different hash salts.
> +        */
> +       pr_info("Calling matched prototype ...\n");
> +       lkdtm_indirect_call(lkdtm_increment_void);
> +
> +       pr_info("Calling mismatched hash salt ...\n");
> +       lkdtm_indirect_call(lkdtm_increment_void_again);
> +
> +       pr_err("FAIL: survived mismatched salt function call!\n");
> +       pr_expected_config(CONFIG_CFI_CLANG);

Should this test also have a "This is probably expected" message if
the compiler doesn't support the __kcfi_salt__ attribute?

Sami

