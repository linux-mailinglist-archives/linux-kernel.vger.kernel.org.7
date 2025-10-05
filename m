Return-Path: <linux-kernel+bounces-842388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE6ABB9AA7
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762533A8E27
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1451CD1E4;
	Sun,  5 Oct 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XgT6lb7n"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63231527B4
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759687770; cv=none; b=W5uZCRH8nMdzPQ16cyqn3xXXGLQjfG+9eSn4aEtpOt+rYAkjDS5ySi9ZSvmU4x6lzgrMGBfZXaFHYK9XSgK+OkTm+JbevKUv65zjO/Fxsp/+yncOmovEnPGKHKUv4OVI07Xr3yYyU08wvuvFueCdimOkR2Cd5a/JPp7BnOnZ7Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759687770; c=relaxed/simple;
	bh=camg0iKThq865GJUn9nyBstkvg6jbOfG+xY6ZZ721ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqHerkRXV26HYSLa4TK1OWAGkIuchAIifjzzvDsmv0D6P9a1L3tmv5D1sN4DofOIh6LIiQRvkW37K1zXfPtrIxLDA8e0mzq5MeLb5GqQNB1nG4OzXKDbJOexVbIOP/ghxiFXJip7IW7F+rS71onMMINwICGUG0TH5WAxpWiluYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XgT6lb7n; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3d5088259eso601978166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759687766; x=1760292566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HywiWrZnA2plSPoOMy05VizUC7aDffpgiwOCnh4rnRA=;
        b=XgT6lb7nYX2FWcz9eNC493CnAFAzxPUNhWRBpzE6Wc0wS87ZcNi8lHMAIsLuHFGbi1
         6KrvObLdbzZQFvzQRV8UkXutuNzPCgJv+n2QM/U6oWjPekNuBNt5GjoUz+/d8gylWohr
         D6bocXrCxqOsllXkieMc4ZvSQUiR7kE67ut3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759687766; x=1760292566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HywiWrZnA2plSPoOMy05VizUC7aDffpgiwOCnh4rnRA=;
        b=VOz70zaJgtiDqWMbRQ1xb9tifmsec6F0e86IDWH07p5pCF7ESPhfGecfjxlabl4Ory
         ljpQe60p2mXuDGw4OA40vXgPOWZZWsgF/+Es7EFHaYaVpAeCW+89QgmsCANbVdMDfPMo
         jfjHcRHeMRDhpGXgK3eg+SQsdtvIGzH3VMaqPu4eaiodIoUnIQfFkFVZkI3FLuTIo5ay
         Vx0Yu7E3LK+pYsWq1b6riUWsVcvlGfQA7HVUZCvDypL1e7hhEWfkulPLYKw/uCoXV6/c
         CleUAQlNFTJFb9m4ZAMeiDSogZTqPahKYV5DIuXPO43b3RiH70NVcpTlXJxGsxuCP9vh
         heRg==
X-Forwarded-Encrypted: i=1; AJvYcCUHswrgM+OH3EDSa/fGgOK5x9DSs3hPO+jVRWoM7vB/8trQA7sPcAO6PT8AvuINNwaFyXEv851zMTle9DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQiua/sdoAPr76xSYMRseNNAvR5gFyxHisLnc/wmv7HjyXpPO
	gsJmXFtGwigovGQObLWq0N4nn/VNou3P5ks88yICa2Pri7/OwFRO4UV3gMrkHZFqQZUybBhXo7d
	vrqJpKYg=
X-Gm-Gg: ASbGnct6WUTafmZYYDUXoQZr6CdBr4XXDZuzojfCqoFJdx9A1+n0J2CUYSoy9mggtJu
	TA2MqpThmPHETEd8WbqiQMNMpUkidmjzxoxUWQOkxeJT11c8GxoBQDBlN4wQoxsclyct2kTLmS+
	ei5WyMQDQEt+MRnFVf3wIfa+UvPPDjZ0VxLDyWCf89NOANa9QxENwo9TRxf/eBoSsqZtwnMt7YO
	suCgjxNuvrcnLS5v7uHb9EFJNC9lZTQOySQ8gZrn8ukK0XMCknLd8Toet+DooO/fDwBVNfjbsJc
	cxv0h4/0ZEcC/UowhEt8r6cHg29ElWwEl8lUrk1yBY/MDMCGGsiCUjFW/hHMaVOQshaBkWEkvFm
	6wlXntmYFkyAZUpIHCixcQheQItURaUBDEJQ1eGYlc/GJXmvSJ1RSdpEvjqEkcTDOXXK8IBc5HQ
	6p8bnhDYcDqEDNfW7c1FlVLv/w02dRuTtYQQWDbpXRRA==
X-Google-Smtp-Source: AGHT+IGL7ajmQ+ankYF9/gY/orVMzTWU1P6OlYX+lOS8/I1rwax2jl6aH+AIzyTFKNQArfwKkNNErA==
X-Received: by 2002:a17:906:7313:b0:b3d:30d8:b897 with SMTP id a640c23a62f3a-b49c1f5ce3bmr1267000766b.14.1759687765722;
        Sun, 05 Oct 2025 11:09:25 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b315sm962321566b.64.2025.10.05.11.09.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 11:09:25 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3d5088259eso601975666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:09:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGqPE/3WqQbeqg5jkxlYu72Jl/zArZ+H+QYD/UHe4BRu3eW6TtLwV+rMOXsWjLuPLNy6HEUnzTBM7V37s=@vger.kernel.org
X-Received: by 2002:a17:906:d542:b0:b48:44bc:44d5 with SMTP id
 a640c23a62f3a-b49c407909cmr1225542266b.43.1759687764580; Sun, 05 Oct 2025
 11:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOKTFv1vh1cvvcLk@kernel.org>
In-Reply-To: <aOKTFv1vh1cvvcLk@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Oct 2025 11:09:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
X-Gm-Features: AS18NWBEWs0_aNhsaDpKimWKOjw3bWPdM4hwd_m5NImN1ornADwAqfSmAg4O0Zc
Message-ID: <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, 
	keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 08:47, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
>      This pull request disables
> TCG_TPM2_HMAC from the default configuration as it does not perform well
> enough [1].
>
> [1] https://lore.kernel.org/linux-integrity/20250825203223.629515-1-jarkko@kernel.org/

This link is entirely useless, and doesn't explain what the problem
was and *why* TPM2_TCG_HMAC shouldn't be on by default.

I think a much better link is

   https://lore.kernel.org/linux-integrity/20250814162252.3504279-1-cfenn@google.com/

which talks about the problems that TPM2_TCG_HMAC causes.

Which weren't just about "not performing well enough", but actually
about how it breaks TPM entirely for some cases.

              Linus

