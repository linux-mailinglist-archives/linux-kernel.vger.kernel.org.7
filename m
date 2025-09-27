Return-Path: <linux-kernel+bounces-835019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B0DBA60CA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 16:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB08F7A3D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDB52E6CCE;
	Sat, 27 Sep 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oLcVGYzt"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86534BA54;
	Sat, 27 Sep 2025 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984910; cv=none; b=p5eopSrnWA4ihDuAYRYVq5wubIfyYEG5mcOBsJVgGJIPCmwz6KZ5XmC7XcJD8hjlirPFblrV+nBEZkWQFGHEjnqHXd5LX1gk3YXFM09jVyIrdaa9XOCqZ/81xMhHCaoxK0TZapvnZcDlFJekTU9Ms4J2qa1iQPHgpbT7n3cuzQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984910; c=relaxed/simple;
	bh=3Udvs1v5FmQeQ7kn/+TXddentjjQjBtjuJ8ItIrVV/E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=J2Wl4tDe9W6EfcREk+j8Zx/042lz6ZbICZQJDccHl8A4UPnk02V5AY7p194a8eKtah1ggftL7HeAZbbvWbiLzxpGdO4WRgk2DTAXy/cg/jp0Kq0HtXck/uoZDZRJC9D0JrBI+YeqaRtt2Hc8FL8dhLotsxTdzz9jbmrL4hnxRWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oLcVGYzt; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758984902; x=1759589702; i=markus.elfring@web.de;
	bh=iVK3AayzSRlHHm7x7pb6sFrbBnJ6Z9HtrSE7jPN4tB4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oLcVGYztKPsKhGnsuqzColD9ibwA8Y/8DLLENSW3bWq6Mwwtpkf1ylSRxQtZ+JOF
	 zfmZJMxi5ltMnKM/V9siQYx32rMnynl2x4e+QCuM9zwt97UFlhJA3voFpcA81D7zE
	 oMhHcsEAwlBc2TwMEo0k0tNn3BGIj7fWDb4jdY7KyRjFexPnCygtkptsJjo7iKAfW
	 voWRdpoLm3Jo3AB011B77e2fU5i1dTyAHXrNmVhZFECcCqHV9V2TTMsjqSpFkVvIS
	 dnsCNvYvw+Br6l3vqbSwDfqrU4zKGqxRhXb8vTS8lUmIts7mPM7DmeEPTk+ZkMXu4
	 wA1kBM6xe4O2FaMXqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M43Kc-1v2WKE1fI8-00FDHm; Sat, 27
 Sep 2025 16:55:02 +0200
Message-ID: <1c96a836-122b-4f7d-a979-03a0bb6c3d4f@web.de>
Date: Sat, 27 Sep 2025 16:54:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: David Arcari <darcari@redhat.com>, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jerry Hoemann <jerry.hoemann@hpe.com>
References: <20250825174554.925679-1-darcari@redhat.com>
Subject: Re: [PATCH] intel_th: core: fix null pointer dereference in
 intel_th_irq
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250825174554.925679-1-darcari@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5DZra6E0yUHwEgKup5cirXDvXY7SWReNqNAxBLjXuBWKbfuIQCE
 ei5woQiaBl2G8spIWtYqE0/A8FYK7/2xLLYUT6yRBoVUIQr+pdp+ehp2t6Zk9XE4yGxSvdT
 nh3zaklUygmh8YPLav+zmjsbLtyMyIUl6UxaTDdYTwGoI4ODNci2PVyiiUizx7wn4jYW6aF
 OB11kRkpQxzrPjWrUNsNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tuSp4TEG+jo=;Ekr/1pQaPRhNjqM9f1cQF2HeUG5
 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
 cKR5BmxnFy26ht+eveZX6jA==

=E2=80=A6
> +++ b/drivers/hwtracing/intel_th/core.c
> @@ -715,7 +715,9 @@ intel_th_subdevice_alloc(struct intel_th *th,
>  int intel_th_output_enable(struct intel_th *th, unsigned int otype)
>  {
>  	struct intel_th_device *thdev;
> -	int src =3D 0, dst =3D 0;
> +	int src =3D 0, dst =3D 0, ret =3D 0;
> +
> +	disable_irq(th->irq);
=E2=80=A6
> -	return 0;
> +	enable_irq(th->irq);
> +	return ret;
>  }
=E2=80=A6

How do you think about to increase the application of scope-based resource=
 management?
https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/interrupt.=
h#L239-L240

Regards,
Markus

