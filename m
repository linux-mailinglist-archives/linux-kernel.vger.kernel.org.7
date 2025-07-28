Return-Path: <linux-kernel+bounces-747463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336C4B1341E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9071896C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE721ADAE;
	Mon, 28 Jul 2025 05:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQLGuqvW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1662E3708;
	Mon, 28 Jul 2025 05:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753680239; cv=none; b=FjGSM3NvDwNhTVFhgX5pCebnriZrdYlufsQ0cZSwCwwtl6AHp643PdKjgBhNwoZ98Ir+AilTWLMGQ23gtyuAMJ+/QbElKNSIPV1KMPFrxhZKbyTFxLnhWb/5uSIAN+8tMyEIPtd5G3EVCcc0mjHo7OtFfbC0k0Wd1hFGz50tsQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753680239; c=relaxed/simple;
	bh=n7UInVqR1KBnpgYDNbC4UDH5h7vmLY25IR7pwVUeBSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1+meog4k9X5gpxqYQYP/sOFynSGp/4m8xVB+II4ztqYB68n4HAc8XfIrUls7LLUTquUpMuTIdlc4239rPqjale6NhsxRcpmj50fk0ahZtPUGHQRBmaVdpLSfRiIv2bgW4rsNjYM41hZeIgsa+dzXMY4uIZ68A+0zhBxH5b+kck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQLGuqvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD84FC4CEE7;
	Mon, 28 Jul 2025 05:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753680239;
	bh=n7UInVqR1KBnpgYDNbC4UDH5h7vmLY25IR7pwVUeBSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQLGuqvW1QtloaVhVp+JC3dg4ZhmfNnJwGd9zMk2RQ70QmlnlHiXjRy0aYY6px8DV
	 UOIxeFqR/OkbBiE9sWCtKxlhvb/w53dMSgxG0stYctMqQojxfhQ4yf6jYvCzzgWOn3
	 hogOiELq4ADAl7byokQQbkQT9RvAe9KxfjljeTnqo6ZV+gLFY4ACOgqgL+b2WZEc0U
	 Y/iVUE8FzVxD8uk9Htpv5+W7Mh8S2cLTSEcMQZpj3bu7KcxZdwc43qJ/oaAo7XslZ2
	 d1QiKzD7HbjWdUzrb3kraQvPXYeBQFf6SkcanY8iSekFaNAtYnZZRMKWZ5/zYmAHZ7
	 LpSFRxRVemw+Q==
Date: Mon, 28 Jul 2025 07:23:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miguel =?utf-8?Q?Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robh@kernel.org, saravanak@google.com, skhan@linuxfoundation.org
Subject: Re: [PATCH] of: replace deprecated strcpy() with strscpy()
Message-ID: <20250728-poised-agile-meerkat-0b2c79@kuoka>
References: <20250724073341.27258-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250724073341.27258-1-miguelgarciaroman8@gmail.com>

On Thu, Jul 24, 2025 at 09:33:41AM +0200, Miguel Garc=C3=ADa wrote:
> @@ -84,7 +84,7 @@ static struct property * __init of_pdt_build_one_prop(p=
handle node, char *prev,
> =20
>  	p->name =3D (char *) (p + 1);
>  	if (special_name) {
> -		strcpy(p->name, special_name);
> +		strscpy(p->name, special_name, sizeof(p->name));

This was not ever tested and I don't think you understand how C pointers
work.

Please document here how exactly did you test this code path?

Best regards,
Krzysztof


