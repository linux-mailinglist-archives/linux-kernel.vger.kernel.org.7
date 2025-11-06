Return-Path: <linux-kernel+bounces-888301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C30C3A6DB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62E018932BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6708280024;
	Thu,  6 Nov 2025 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4m31jUk"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710D2472B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426890; cv=none; b=iP5d9d+kh8Ge7zoBJDYXBJ49YPYAQjae00CH6wapNGJ7HuDykDr/mmtqbGO2m43NT5YA3XQRQAQwXfKl+LJ/hVLql014GJ3y5WpknEUFuW3zQAs4yDZ/Nvg+GWaasTfyZQcYYPLFH11wU398u+6poOrB5Vbg2ME12WXi2ocyQyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426890; c=relaxed/simple;
	bh=ir//lFT9wS6wCSvmIE4K+HR90jLm5Sr1r9449X9pQYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcvcmO7c2DOUsci5JdRxV+hjgTpx7eeYh5x1kBbjyd8gJIa1Q9wvPNw8sWjLW1PH+pT6CWSP40aqqfhGKtkLKw0O/t0IeX9BfRbZgjA0gvqWJCovXv/Gq24iKHCm7LGHMj8yakMWyrLf25wSahejgvbFKZRuOV/OWR1D209h90Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4m31jUk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so1423084a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762426887; x=1763031687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ir//lFT9wS6wCSvmIE4K+HR90jLm5Sr1r9449X9pQYI=;
        b=P4m31jUkMQGtagzKYPdHFcoDDe0O3G6tpphUTiCMePdNR28d/YuWzkdD7H1ojp3CIB
         Y9bbnkby8t4Rc01y5804HlTmXS4fLQFL4suesUgNcyZ8v6oJ2Ad8HBEHMyB1yBjvSGIM
         KnvF1PwsNuGPYVSOIV1ZQ118qnuN3ZkTk2xaLngsnvGukkHu1XG3pDw1FoZdEgKKVtPS
         rzht2g8avq/MIhqtsoywQ+6OlBPNIQV/09pisKXF5LqtDla6HWJzCHlBs6+Ht8MTydYm
         Xqq/dW1YmrJVE3l7BhWq+6rMsQVB3JMnAaxZ2AnWq0F3hUlmDMtsiq1PYZeRSVSWZcKv
         gWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426887; x=1763031687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ir//lFT9wS6wCSvmIE4K+HR90jLm5Sr1r9449X9pQYI=;
        b=uQ7/IV7YPRUwnOiEq6gFC8ZKCpZTlq5QdEd69p+t7EdkwT3LrRcFsqwRCos7c+fkp+
         AiU1D0dk3V3AE5Th7gdQzsAA3V8d08H8h6boynlTUkRcCCD3xQ8M/6ArEwqwrkyQSZYx
         rTvbWexv/oDbYtsyV3kdzPq+ZgrYrj8FgR2t3iG0MlJs14JVBcdM2g77ClX8VkamQZLo
         Cd6o5VFqWbrqdhgbaaDYl1IoCVhP58gNCo25gqJnYAHlWryZ+hIZFM9aCRE3MpqlX+fQ
         OqZL8n/+ZPovfDAxNNHJZUN2GGRDV2ZuDMAyE9ZgpcU6fRj1V7ok0Y5CSdfiQweilTKM
         V8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUEs65Z4omjcCArLDj0qSpQEpU6fYYoP9ZGw0usc7G0R0rHrIzm7974LkWQVqu2a3NMaof8RUQeoChss7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPsahf0vVETqql+ca8FV2bNXunWzG8sB9/R4zhbDCvKHgvXiw
	1YEqEEYZoZ5BsRXz9QUcgdErK0XjmcbcVrFHuuG8AkdL51blJmpiE1nfZSLTTXpHcGFr+HH1HNe
	wy0JAAA7CnHpEbViL/V6IjwlCzddJ3OQ=
X-Gm-Gg: ASbGncsdLPnPK11qOr7Yzb480cw567Zk8eWIm84Vh/YTWGLER2KcRDCbXjg31ak4aM1
	lej8v9+kJnYf0HLRFPCUlMLLN8ERNTH+hsRPNe9DLICbzXX4PoNykZeguYH1Anf+OgV5F9tgnCA
	boQR6CEaDDpkTGfsDH3LCR7EnyEd4bcU1pYZ4MXMF1qhKkjOUjaubnem4HTTkiaLnfF3I4ph6fZ
	9e91JTCGcb9gtqllf5UX+1yjU0DvDcXjWjWJqz/ZXt1nm+dqEqc7tpdqCu4+Q==
X-Google-Smtp-Source: AGHT+IE3ZLXP3+oYOCDOf8HdHiiPIx4UVriZLNHQt5QqAgQyg7lMQ1CUloE2bPCtkRDLKsQ1PmtiKY3RDXWEaZ6PDlg=
X-Received: by 2002:a05:6402:1eca:b0:640:ceef:7e44 with SMTP id
 4fb4d7f45d1cf-64105a5c99amr6575408a12.28.1762426886854; Thu, 06 Nov 2025
 03:01:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105161845.2535367-1-a.shimko.dev@gmail.com> <20251106104228.GP2912318@black.igk.intel.com>
In-Reply-To: <20251106104228.GP2912318@black.igk.intel.com>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Thu, 6 Nov 2025 14:01:15 +0300
X-Gm-Features: AWmQ_bmlkS6-iACEnyny5YPvKbBIRoPsEPwqNcbfawNSc0tFOMLrZxEL14qOOkc
Message-ID: <CAOPX745kvE-5mh8PjTzwboTR1uKijvgG72YOb4pOjXzE4+3qaQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: designware: Replace magic numbers with named constants
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 1:43=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> I think it adds too much to be honest.

Hi Mika,

Thank you for the review.

 I'll prepare v2 that addresses all your feedback.
Will send the revised version shortly.

Best regards,
Artem

