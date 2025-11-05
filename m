Return-Path: <linux-kernel+bounces-885747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ACCC33D33
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 532D034C9DE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A432222D0;
	Wed,  5 Nov 2025 03:01:18 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7278D1E3787;
	Wed,  5 Nov 2025 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762311678; cv=none; b=c6X8EqV1vzCs2F/lwKgRjpitl5Dn3NoiVLsqYyZDCrwblTfSZ5QRqEmwkwvCcedY3dUGWtw/WqOkPrKhJBBzQAl1HfsgDptfQAr09WwVgsup1zcAe8FKYJA7EzvsLDPuNt+CFRFgi1Ia6+BnF0ZTmzSUBRhohVf10KrkEuBHUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762311678; c=relaxed/simple;
	bh=o+SAjtlJICA6qm1etpb2J74yb7rHf7Fu+PY8KLWYuaU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YjFwSCeKtIYj6sRBICcfWpudcNr03TpXAjrs2/j4XsevCFv3s6dPiiqEnSiQmRSIwTNl/xAGSkErpggGuE1QKlWaM8Y7PMSvZbgR9ibzsu031M/nFnKmMrIs75vZhzPBAS79pexUEWt6oUiuqqmCLOuM2vLDNLpCgnHaDUzmdiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 74B5492009D; Wed,  5 Nov 2025 04:01:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 6F2E292009B;
	Wed,  5 Nov 2025 03:01:08 +0000 (GMT)
Date: Wed, 5 Nov 2025 03:01:08 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>
cc: richard.henderson@linaro.org, linux-alpha@vger.kernel.org, 
    linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH v2] Add Magnus Lindholm to MAINTAINERS (Alpha port)
In-Reply-To: <CAEdQ38E9hWDy65vOdjwmTcy5tqtNvY8eebV7c9Sxx3e9Y4y8JA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2511050258230.25436@angie.orcam.me.uk>
References: <20251104103525.26410-1-linmag7@gmail.com> <CAEdQ38E9hWDy65vOdjwmTcy5tqtNvY8eebV7c9Sxx3e9Y4y8JA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Nov 2025, Matt Turner wrote:

> > Add Magnus Lindholm as maintainer for alpha port
> >
> > Changes since v1:
> > - Rephrase commit message and email subject
> >
> > Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> 
> Acked-by: Matt Turner <mattst88@gmail.com>
> 
> Thanks Magnus! I will take this patch through my tree ASAP so we can
> get your kernel.org account set up sooner rather than later.

 Lovely!  Thanks for volunteering as there's going to be plenty of stuff 
thrown your way soon (none has been forgotten!).

  Maciej

