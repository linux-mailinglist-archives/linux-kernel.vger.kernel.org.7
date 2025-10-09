Return-Path: <linux-kernel+bounces-847008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CA5BC9A35
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60B1B3535D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716C12EB84B;
	Thu,  9 Oct 2025 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oU0HepS2"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047292EB5A4;
	Thu,  9 Oct 2025 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760021544; cv=none; b=ZCAf05Eq1qaVqUvgB722hrGsAFJDkY2+NzipXIAjdmynULnssuGAgAyxTfR72usgY89OCJNHUPgSIY6+k0ZR6kFIdgzHJ7+NrUzf/cb9SKkSorIE3cgmxwuPiVrEsdODTOpYdyenLZGzQKdDGON0nCeYSRb0DUnJJUjIliuFrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760021544; c=relaxed/simple;
	bh=xTL7DiG+Wk108ylAXsFi8OtRDEe6Q9eiMtDN6TQ8Apk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bw17jKGU66EDltwvsRynnQeqDvEmMFj7Oxlc7Flf7Rt7qMYwY3ynrqYMiG9dA2jbCbtYVFYYe0xppPf6pB38Tj+t+i+omJaEFKT4tzhF1H0eJlrVO5xFSvTe/67DwECl2fpuOC5J5WGkicBOjdwJ5wiFwKOndRBH08HUncCOYLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oU0HepS2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760021540;
	bh=xTL7DiG+Wk108ylAXsFi8OtRDEe6Q9eiMtDN6TQ8Apk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oU0HepS2IWZZrhWZYuEfvO/ws2PxfGE4XKGmToRtThn9ggtmE+yHPSaXnHJgeMW8s
	 HsKmBk6g1OsQYwqbilxLK+LpbJDWdWZlee40S7xQfirBLQ3IzhnTCeP5S+orEv0vXU
	 jSlm5MGJ1dY4wMi/UbDykqrxN3X1n8lf7haASYuVcZ1l7H1cJE8Sn4mdtg2KOebKV0
	 YaictgUawY/PEac8aIiDdn8LLgM8KS7RJTG7T4H4KTCb/EegoO941FYyPYSeKcnVdb
	 dveNCofdcEuQPHmcemW6kzP4PLG4Su5P5C8+IzSYdXQNU8Ph6X8ccExe4fxycb0ZdI
	 xhmJW7rFsvk6Q==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 71DE917E009B;
	Thu,  9 Oct 2025 16:52:19 +0200 (CEST)
Date: Thu, 9 Oct 2025 16:52:16 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Steven Price <steven.price@arm.com>, Rain Yang <jiyu.yang@oss.nxp.com>,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.co, simona@ffwll.ch,
 marek.vasut@mailbox.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Rain Yang <jiyu.yang@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-valhall: make mali-supply
 optional
Message-ID: <20251009165216.3670c6bf@fedora>
In-Reply-To: <aOfKDbjIHnFi6AX1@lizhi-Precision-Tower-5810>
References: <20250928090334.35389-1-jiyu.yang@oss.nxp.com>
	<7c3b219f-f504-4c4c-a13a-6a25a0eda277@arm.com>
	<aOfKDbjIHnFi6AX1@lizhi-Precision-Tower-5810>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Oct 2025 10:43:25 -0400
Frank Li <Frank.li@nxp.com> wrote:

> On Thu, Oct 09, 2025 at 02:00:43PM +0100, Steven Price wrote:
> > Series applied to drm-misc-next.  
> 
> I have not seen DT team's acked tag for binding.

Rob acked it.

> 
> Frank
> 
> >
> > Thanks,
> > Steve
> >
> > On 28/09/2025 10:03, Rain Yang wrote:  
> > > From: Rain Yang <jiyu.yang@nxp.com>
> > >
> > > Not all platforms require the mali-supply regulator. This change removes
> > > it from the required list in the binding schema, and make mali-supply
> > > required for rk3588 only.
> > >
> > > Signed-off-by: Rain Yang <jiyu.yang@nxp.com>
> > > ---
> > >  .../devicetree/bindings/gpu/arm,mali-valhall-csf.yaml          | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > > index b220cbd5362f..ef9791d8ed95 100644
> > > --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > > @@ -92,7 +92,6 @@ required:
> > >    - interrupts
> > >    - interrupt-names
> > >    - clocks
> > > -  - mali-supply
> > >
> > >  additionalProperties: false
> > >
> > > @@ -109,6 +108,8 @@ allOf:
> > >          power-domains:
> > >            maxItems: 1
> > >          power-domain-names: false
> > > +      required:
> > > +        - mali-supply
> > >
> > >  examples:
> > >    - |  
> >  


