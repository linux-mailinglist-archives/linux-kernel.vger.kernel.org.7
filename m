Return-Path: <linux-kernel+bounces-898272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92424C54BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 840784E4352
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081442E0418;
	Wed, 12 Nov 2025 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="E49l6TGP"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4E262FDD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987118; cv=none; b=H3dIDjj4N6Xlm9coj/FJHGJKm/IavHVpYNAKKD/66fmySlTqeBdZjv1Ud0HJ84vVJycUkJrb5bt/t6CZV/iuMpkjOw6pM9nDOgsrOq3GoiW3nHCmPaEvtYJdXhu+Wh6Fj+kfqOs0L5KXpbuc16s/lZYVI+2FWrxQii/LO2+PmcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987118; c=relaxed/simple;
	bh=FGoy+1mf/iEZbqlUoKE5eP1goQQPVxc0Ioi3mVzbTLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXWLZQK7kq5X8OEzVQrsKtcD9l/gf/OXEpP8rN9hvUBK4tCkmziNx7Ubb0pmCk+qIRQm82TUlCcKyN0nOold4RNeQ2a5fONuNxlpruUKp3Kngpe0QJW/4FmuGloPiWglvrX+KL/QhBmhlxs6Aid3knjtb1kJBgL5HeF0HwS6vxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=E49l6TGP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b25ed53fcbso27247985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762987116; x=1763591916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ILfLXbAJNiJYEiwM9cTPJzVvJxoZR1GJ61P0Au/eDQ=;
        b=E49l6TGPhXZT6EfM0aOToWidONhfJrcn0UfWWGZZDtgQCQKr+sdz61YFmou2PSRs7+
         uHB90aQLJitR4m0lsf0FcuL2dObWyL0be0AJcE0lmUcc/tX51z+Ocg9bOknXVN+jZ+Py
         FckM+3svCsiUuMSKMNtOAsbiVd5H9gug/f5B5exUokQYE3c0CHm5hrIOVmnbwEWT96ed
         4rVhy9Gk/E6fIEphFnoHPMTKSGidcIa65E70sISn+xxibmSJGGcQg+DDfQzSx5Wc0sbL
         8P9qDdpoE7wm2L1nJTxDFGsAk4u+kd7J5mMa8GWdBTeiLT/IjYk0LAN7mEzpyHh7ZsGM
         J0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762987116; x=1763591916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ILfLXbAJNiJYEiwM9cTPJzVvJxoZR1GJ61P0Au/eDQ=;
        b=iUSR0hbepc/ZAbsgoGfDROEJJqYAiVpAxduqjC3dNouDUAzODr/Wfchysb0ofslFVK
         178nzscnUgWQNQOYAUqnTNRzgRGlaFDPVpaXDIup3LDJcMicH17wefUfeSjCt8SlVBCv
         iVla/mboo0rCf1qhewgrqsb94e4fuHk9pXh1cwef2UF/ghirInjcuLs8PJht5laiHNqH
         vS+tlLG85oBpF99B7Guiyl3OnC0blc1CffYE59AC9EJUZz4oYsH2AsHwRVZ4q8VcY0rO
         LGdYbyz+/qRTEG7Ricj8wFii9ruugdtpjhK+FptXEfeM6wEvNf3Dbvzsfd9pj8Tb2h9X
         ppyg==
X-Forwarded-Encrypted: i=1; AJvYcCVe28IaCSOTiLIu7yqxxFqSWknmf/XwSt8V+evQc2dzw41D+u3vu6wJLh9XcX9Mh0XbTudORgWEZTjvwyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdduiX1XQaWDC3Bo0JWjKiR/33ysu05K84EHQVEAfvWhwgFFhh
	2xSBAHzL4xOfBR6jvqa3lLhONCrZEtAS12ArxXkUwQSbkCD917l5eoNmyb9jLyAlR6w=
X-Gm-Gg: ASbGncs29sXE4nK2vN39MUogC4OP61HBevxvh7/Gg3jZJO9eWudNHzlfBJc7SCUr4jo
	zl0zV6xyi0J3XwzyOddt6HbaZKKzv9a+iazhS5xpM2gOH/g0qkm+6BqoQZDKMWmV2eaQQNrfaNI
	bafbtH2v4l4ZVm3SF+CKaY937rQnwD4ZZKcg4vOKfmZ2PVN9SBA29zZWRJdz8CbLYIxwFRtd68r
	S7qqhbCjz39LtyirpDXuGD12/5cwvpaJEDcmxR6pp7FHKV5bMPgNZbzoqBNWwW5ANLWLIwIjqcr
	Rg8L5Hd1W7utVXaV4FDh2ahH+iKeFGYqCi4Fc5DXsO0350N6g5S88mEptw6mkck7NhdeeUXQUUH
	gSofcadPyFQv1Bi3WOWuLnVZw3igYo4XcHXgKkyHcdSFrDBG72TNnNp+ld3oJfoYoSn+uPkHpre
	Uh7G4ZiAMxejBEQkQEkjniTcH51HIIfgD8tvlV8oBBqWbLcBGmZEaJkCD0Md0=
X-Google-Smtp-Source: AGHT+IGs+xKxGG8LfbNME4hLPEzsboowTSnj+CXqHzwlqSKbwOsCtnyf86uAwOtcaA/KTC+/iIu9eA==
X-Received: by 2002:a05:620a:2911:b0:8b2:294:1cf1 with SMTP id af79cd13be357-8b29b768961mr649526185a.29.1762987115831;
        Wed, 12 Nov 2025 14:38:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aee9fb7fsm11841685a.1.2025.11.12.14.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:38:35 -0800 (PST)
Date: Wed, 12 Nov 2025 17:38:33 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 2/3] cxl/acpi: Group xor arithmetric setup code in a
 single block
Message-ID: <aRUMaWmN9uKMdY_D@gourry-fedora-PF4VCD3F>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <20251112205105.1271726-3-rrichter@amd.com>
 <aRUMBz8wl1ePak8O@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRUMBz8wl1ePak8O@gourry-fedora-PF4VCD3F>

On Wed, Nov 12, 2025 at 05:36:55PM -0500, Gregory Price wrote:
> On Wed, Nov 12, 2025 at 09:51:03PM +0100, Robert Richter wrote:
> > Simplify the xor arithmetric setup code by grouping it in a single
> > block. No need to split the block for QoS setup.
> > 
> > It is safe to reorder the call of cxl_setup_extended_linear_cache()
> > because there are no dependencies.
> > 
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
>

Sigh, sorry, hit the wrong macro, DJ please drop this SoB

Reviewed-by: Gregory Price <gourry@gourry.net>

