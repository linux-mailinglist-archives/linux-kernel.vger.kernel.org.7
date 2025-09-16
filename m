Return-Path: <linux-kernel+bounces-818415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF57B59177
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE7232189C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC7F28C84F;
	Tue, 16 Sep 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="EKCJTAgE"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E64D283FD8;
	Tue, 16 Sep 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013147; cv=pass; b=cB0NY+xu39hxRLic97acKbwnFQt3HKImfOj2mMJvSR92SDJR61h3XQ9xjLnRuggu7XChBandtD4Of+cQ1/hWUzIo0ZoMd7GFruiYJ41eXna5L3qWCdNTa0iqWM7JART7LEmOwXhf3GxQqlULrebSPFCOiOJNO91TI4MYlgCMVZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013147; c=relaxed/simple;
	bh=3DpbfjhNcYPny3opqvxM/G0alwk8XIxFrvBqhZGsL8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6DjlRBavpEAEEk2M4pjUNWFAiai9A2c7C+AKQ3xeZu2xZ8g6YJ0RmLtgRCbZkvZBxnQ5DeLJuibNaAYkQ/UI8qvRj/1tzhZubUbBoYjCcDKT296JQx7VjDkUiGp3iEGfWp4Vf/T+BVc7tYNDQ/zR0nPwgwoSD/4MQaq3t9p/w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=EKCJTAgE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758013129; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DlGRx1sHBM1VjFZpqb9GzXR45EgfBj1Alpk5uB/oOv1djKJcxWenWpKpt7+ZoxNMKIVPa6UoHsBtZFzwsZf3MYlZfjPqY2x9L1/lQqwKrHr7j1nx5Og0UfTtIVAMO1hhW3nQVoFPcIN+1WGOYjq0yaqBdRJjOahhvTAGX5QrdgI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758013129; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3DpbfjhNcYPny3opqvxM/G0alwk8XIxFrvBqhZGsL8g=; 
	b=g3OfcSn+hvsE6ovT+pY8HmViqNxCJqrCgdfr0k0I01HhvyNUkJcN7UMEODto/NSjt4zmSbku1VPnw3qK7xljqItoTGVvu7aTq0PnFV3p2C7opzPFb9TlRWezRxoFj4mecuJWGP9m8okQCXNb9SQx87ilotwjcGW6cz+KXyhzkOs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758013129;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=3DpbfjhNcYPny3opqvxM/G0alwk8XIxFrvBqhZGsL8g=;
	b=EKCJTAgEdkqU7Xe8Bg88E/fUzojbXLWOgtO1T9xuaGhnprD5noQ0A0/y2xKVzoXk
	Qqfp0RzbwKZsu48yBY9cXoQ1uc+7Xc52tt4uA7hrvBmsL4uvnDPnTb0IIrMUs/Jwn+l
	FAGYlOnUXncaxY9t0Y9Towffbv8lrrxU00c9ezEM=
Received: by mx.zohomail.com with SMTPS id 1758013127114512.6864936718232;
	Tue, 16 Sep 2025 01:58:47 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Conor Dooley <conor@kernel.org>, Chia-I Wu <olvaffe@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject:
 Re: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall-csf: add MediaTek MT8196
 compatible
Date: Tue, 16 Sep 2025 10:58:40 +0200
Message-ID: <6418135.lOV4Wx5bFT@workhorse>
In-Reply-To:
 <CAPaKu7TEjG3sWamy3k_YLig=208oXLPhMmbCvPOf96iEL0-uig@mail.gmail.com>
References:
 <20250913002155.1163908-1-olvaffe@gmail.com>
 <20250915-deodorize-proxy-b18e41fa8668@spud>
 <CAPaKu7TEjG3sWamy3k_YLig=208oXLPhMmbCvPOf96iEL0-uig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 16 September 2025 06:21:10 Central European Summer Time Chia-I =
Wu wrote:
> On Mon, Sep 15, 2025 at 10:52=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Mon, Sep 15, 2025 at 06:51:16PM +0100, Conor Dooley wrote:
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Hmm, actually there seems to be a more complete binding proposed here:
> > https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250912=
=2Dmt8196-gpufreq-v2-1-779a8a3729d9@collabora.com/
> Right. I tried to add the compatible to the binding (this patch)
> before adding it to the driver (next patch).
>=20
> If this patch is not a prerequisite for the driver change, I can drop
> this. Or perhaps there is a better way?
>=20

Depends on what you want to do with the driver change; I could pull it
into my patch series (I need it as a prerequisite now anyway, as v3
will get rid of the clocks for MT8196 in the binding, which means it
needs to have a flag for this in the soc_data struct you've added)

I think that would be the easiest solution so that we don't step on
each other's toes, as long as you think the driver change is
basically in its final form right now and does not need major
revisions you'd still like to make yourself without having to
coordinate submission through me.

Or, the most roundabout option: I split the bindings I submitted
into a separate series, and then we can both declare them as deps
for our driver changes. That might thoroughly confuse maintainers
though. But then you can declare a dep on the bindings series and
I can declare a dep on the bindings series and your patch.

Kind regards,
Nicolas Frattaroli



