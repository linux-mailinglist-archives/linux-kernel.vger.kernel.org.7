Return-Path: <linux-kernel+bounces-745900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5B6B12036
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B3DAA4AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4057A202C26;
	Fri, 25 Jul 2025 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="Ybe5IAlx";
	dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b="JZYVTCqW"
Received: from e3i314.smtp2go.com (e3i314.smtp2go.com [158.120.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420141E834E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454312; cv=none; b=d3jOKZ/chqmudZ5GRfyBe6pH3xAIZg+YlG1urP5DbMfyBGwbXi4K36R64fxsrIW1TlPmwZe8Pkmi0F5wJwWnNiaLe6EwktXHx1SiIzU/q2RBSq6HGWZYGdEvKDfoghHw1SdtA4IcUNYzJH5WBsp0wxszMkdEylhWnNmlPVSpjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454312; c=relaxed/simple;
	bh=f2gz3zGxkAy/2wDgsqilnhq1wXsz6S26o2PLoxsfPy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=PwYr4zlFn3hOsHPEQDf9w/36R1RbLuNoYJ+cWa+sCz1yvKO1FnVcS9HBzc4P/QBT++vDwQjtE0br7jT/aNGGqEwf7zw9isfpmPlDJokSA58+hJyHtwOO45dEvNtU5OqGwEnMtQJOxtzyM/KhZB+MHel9bMnAtFbvv9EeKBvLJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev; spf=pass smtp.mailfrom=em1255854.medip.dev; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=Ybe5IAlx; dkim=pass (2048-bit key) header.d=medip.dev header.i=@medip.dev header.b=JZYVTCqW; arc=none smtp.client-ip=158.120.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=medip.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1255854.medip.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753454308; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=f2gz3zGxkAy/2wDgsqilnhq1wXsz6S26o2PLoxsfPy0=;
 b=Ybe5IAlx8IRwvBa/43/jCr5yiijvcj/JreJt052Caz4EllQI9yHdUQkI3j2ER5FG0YkbL
 LZz4oGFlTUj2Kke5OZNhQ0OKeDFlZPEk19gzep3jzQpchaCj21mr8XkwibyTXi4s4ugOAAd
 NxO6MohStjknOnKV3JKqi3aPRspVlXcgCWjHQ2yqbN/zn6mwXOppUCjQ2TQA+kaQm0yzxOu
 l1hetVUOo+Fj12yxdIHgiCA6LhD7TzseaRJiS+S+zMFX2EQML5yBWgfoZ+YvFPnb70s2JbJ
 /XfB5qxTPthRkrj1uMXisdJaSrGoJgO664Fl9EPCmrwcHuPy6tK4kpM6Vhqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=medip.dev;
 i=@medip.dev; q=dns/txt; s=s1255854; t=1753454308; h=from : subject :
 to : message-id : date;
 bh=f2gz3zGxkAy/2wDgsqilnhq1wXsz6S26o2PLoxsfPy0=;
 b=JZYVTCqWpQ7KcdxWayLad8l31IUm7DepJToQHF8dZZlgLUcviBK3OkXDfmegpVRFGRUwH
 Df8AjVLQI9NKpSmkc+tq3l3s/W9h16HNv2oOPmxjZRF3Y1s8yJcDQokMTYuYdXW5DWZ4sh/
 ErjcCDBD6H68AygeS4NjOoP5cCQQEWoRQr1Gvp0NdX7b37BVJcp/IVi9OIY2LrhW43rCREU
 AiF22vALDPDBlMxdL7IkXtJ7ZQ2p82yu79rEZNdHjSGQqrYJE8sdREdDbJWW1H2xOzReIZ4
 7ndvcQAOsQeb3OmdvnisTkqjwa8UDPs88J+6rg1fR3VsDYYdE6wMz0xXpU0g==
Received: from [10.152.250.198] (helo=vilez.localnet)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1-S2G)
	(envelope-from <edip@medip.dev>)
	id 1ufJYy-FnQW0hPs3bB-1ILi;
	Fri, 25 Jul 2025 14:38:20 +0000
From: Edip Hazuri <edip@medip.dev>
To: tiwai@suse.de
Reply-To: 87a54skajh.wl-tiwai@suse.de
Cc: edip@medip.dev, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 perex@perex.cz, stable@vger.kernel.org, tiwai@suse.com
Subject: Re: [PATCH] ALSA: hda/realtek - Fix mute LED for HP Victus 16-r1xxx
Date: Fri, 25 Jul 2025 17:38:10 +0300
Message-ID: <5951329.DvuYhMxLoT@vilez>
In-Reply-To: <87a54skajh.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 1255854m:1255854ay30w_v:1255854sR_qNS80Cz
X-smtpcorp-track: NgKH3i-bbjk-.bHhPYUlF2STk.-MIirApdVCk

On Friday, July 25, 2025 10:13:38=E2=80=AFAM GMT+03:00 Takashi Iwai wrote:
> On Thu, 24 Jul 2025 23:07:56 +0200,
>=20
> edip@medip.dev wrote:
> > From: Edip Hazuri <edip@medip.dev>
> >=20
> > The mute led on this laptop is using ALC245 but requires a quirk to work
> > This patch enables the existing quirk for the device.
> >=20
> > Tested on Victus 16-r1xxx Laptop. The LED behaviour works
> > as intended.
> >=20
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Edip Hazuri <edip@medip.dev>
>=20
> The HD-audio code was relocated and split to different files recently
> (for 6.17 kernel), e.g. this Realtek codec is now located in
> sound/hda/codecs/realtek/alc269.c.
>=20
> As I already closed the changes for 6.16 and it'll be put for
> 6.17-rc1, could you rebase on for-next branch of sound.git tree and
> resubmit?
>=20
>=20
> thanks,
>=20
> Takashi
Hi

I'll rebase and resubmit it as soon as possible
Thank you



