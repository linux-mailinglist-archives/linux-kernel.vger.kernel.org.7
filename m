Return-Path: <linux-kernel+bounces-886581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD35C36003
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE2B1A20E56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1D5329C44;
	Wed,  5 Nov 2025 14:14:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D482C0282
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352089; cv=none; b=J3yynctgNK3u/WlE/10tGRkIo3awY/0DyZ0tPJa2kGxTtZt0qbyaxygNHV25D2aOwCLLt7i/Vgk9oQKwzDJlRIYZN3MhMcMG3zlxW8c44JDjzm1STaE/Pmx+TekduKPXClG3vLTyT11ROe6cfLAyoqCc1H7M345Tnu6NWk31PQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352089; c=relaxed/simple;
	bh=URL2y5nVGwxdo0RO9T8imwteXkKHxgwCepSR1UM6kV8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUlTb+hFFtc4fyLC+AeSCUIH4m2Em5mpB+umTN1KLqqu90ahOUh+lWPq5sk/DRGMr0F1kaZun1B5noDTynrZ+rq+3kyAcda6DeWXKjcZhXTjn89ZeqWuDs4UgL7OV02Un9ij3AKd2lxHE1zST7u7Quhh9DJlw5j0GPQzOnWn/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGeHa-0000lk-L5; Wed, 05 Nov 2025 15:14:42 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGeHa-007D8N-1Q;
	Wed, 05 Nov 2025 15:14:42 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGeHa-000000009sm-1Ylk;
	Wed, 05 Nov 2025 15:14:42 +0100
Message-ID: <d27711cca1c034a06d58fc46ed0d55f59f94d281.camel@pengutronix.de>
Subject: Re: [PATCH RFC] reset: fix BIT macro reference
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Encrow Thorne <jyc0019@gmail.com>, Troy Mitchell
 <troy.mitchell@linux.dev>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 05 Nov 2025 15:14:42 +0100
In-Reply-To: <20251105-rfc-reset-include-bits-v1-1-d7e1bbc7e1ab@gmail.com>
References: <20251105-rfc-reset-include-bits-v1-1-d7e1bbc7e1ab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On Mi, 2025-11-05 at 21:35 +0800, Encrow Thorne wrote:
> RESET_CONTROL_FLAGS_BIT_* macros use BIT(), but reset.h does not
> include bits.h or bitops.h. This causes compilation errors when
> including reset.h standalone.
>=20
> Include bits.h to make reset.h self-contained.
>=20
> This patch is sent as RFC to discuss whether including bits.h in
> reset.h is appropriate.

Yes, this is appropriate, thank you.

> Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
> ---
>  include/linux/reset.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 840d75d172f6..d3102eef085e 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -5,6 +5,7 @@
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> +#include <linux/bits.h>

Please keep includes sorted alphabetically.

regards
Philipp

