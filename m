Return-Path: <linux-kernel+bounces-747255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB15BB13192
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 21:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E681C1892813
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9471622173A;
	Sun, 27 Jul 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Vx7bWqLk"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D1772614
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753645571; cv=none; b=MAx9Ybk9vw0bnt1tME3GMP+LYsjZiiv47FZo0eRcWWdYJ6HcBn4+9az61ewKfBvqzW6NZJn3tLjpXHe0i7aC/Ty8ToKxM8MVQmxE4sTncxrwNCDyHLyP+ZnV1xSBF3rWshZmqG6mU4hMUbyxtzzfmrdPd8baTfQMlKqUMT3Rsmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753645571; c=relaxed/simple;
	bh=NMxs303x29xRbu7yKtcMITkOj1J1tBVhemnrnPzYTUc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cEvmGEujQrd6dfRRDD5v7mrEuduqb3lTJxn2O3ZSjY579yELgrr1BwIjgz+Iy5GyCaE8S6uyqirHR5inRVHUoB+fDoqes6WP91ynJDhvFSAGP7MC4OKLyEhXuyT96SrNeRI6SJFs37uMCRSGnssm/1ed+VSlHbTbPYhJIybmdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Vx7bWqLk; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753645564; x=1754250364; i=markus.elfring@web.de;
	bh=w7wV4bQw6I+f2MyxezAE54mSoFDxSCTYKVYPfxLRr80=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Vx7bWqLkRODyKqLZfJndRVx+NdUXcSNaKe9cUIunhzwVY8awf+YizU2oLQR1RJZC
	 2oKpXJgtX60fqluDfdHentWrAPPvJndT0MXKmtB8ndt/QG6U614nYM2Vzp0K91Vgn
	 vJ+MrV7sQSE70GXhhiU2Ikv/9cz7wS0aPwCzJMM/vWutrh5ZL76zBqB8W7jmbRf6I
	 N+aZ6tsFHApWMHVo0HRocnjaRgGkUp61FgdrivPt7XvQd+wY1H53e5G8WfkH7PefG
	 haN2XkPYeBmIlOXqa4gfPpbfNSPjhcahyy/gPWjTQm7d3oyumh3PZm03ptqOP36V9
	 TtK6lJeCCPXIccTVyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Euv-1uhVIH2JFl-00H3nV; Sun, 27
 Jul 2025 21:46:04 +0200
Message-ID: <3f9121a0-30ae-4dde-8c22-be195dfc4fe4@web.de>
Date: Sun, 27 Jul 2025 21:46:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Salah Triki <salah.triki@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <aCdkIkNOQgnA5Pou@pc>
Subject: Re: [PATCH] drm/amdgpu: check return value of xa_store()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aCdkIkNOQgnA5Pou@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/UEPh5id4lqeb+TOA1F8EsVORfB81cvRTm/3ntn9RE3QjgTxHvO
 QmkaeUpukQGSzRTZLbW9OxqV5MYL7NiLNttLqBOJbuZ8ZEYpRLFeXwQZTb9YameuFdaiaja
 eUpa2NtQfkgDY0SthmK/DfbyXmxaZh/5q1UShwxio4vPZyV4zS712gytH2K3tRv894B4brs
 2sr5WiAZBqfW+lIpyJ7zQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2aP1Vn8Tx0Q=;rRgnaTAUe1/4xR35uI1KMVsHDsu
 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

> xa_store() may fail so check its return value and if error occurred free
> numa_info and return NULL.

* I find such a change description improvable another bit.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.16-rc7#n145


Regards,
Markus

