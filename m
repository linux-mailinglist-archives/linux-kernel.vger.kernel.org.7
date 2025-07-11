Return-Path: <linux-kernel+bounces-727110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D64B01528
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A49B764233
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC311F4722;
	Fri, 11 Jul 2025 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="wJb5lVgd"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640961F1306
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752220160; cv=none; b=tfbEHLyuirogB/hZw9Cnw1SCOyBli334jlf3SWR/L9x+F63m+Is3RMuRJlIpwxEXkhOIqlqFSnSfMLzVJJIJX0WXh8cXI0BCx6HovwpRDnkDHgqIN4uaHg6LtuVNtV5kVBE4XEe4FYbxggL6UQOS+OWP8cVNINpN5Mzvh+xAVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752220160; c=relaxed/simple;
	bh=mnRVnOn745rc6zlhW3a70pKs5ebcseZrteDQiLGcxlI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DSaFvArleAtTt00HP/gPqLsxD4/mfjHruiu/tp2JE6ydHfD5+gCrfsflLjv5IgQniDlzujhW3SwJiP91QUnYP+HfbnWMC3NBXAeWxJhJUTwhMCEA9u/ICH1Kql4pVro5S3TxBamI13eev0B0HABSGLPBzFqUn+Ikgfbr8GQBr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=wJb5lVgd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so362958966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752220155; x=1752824955; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuj2RXHOOyKDpGAVts46ctP8tG8E0kUzK0aOC3W5/W4=;
        b=wJb5lVgdrc+Awpros3y9s4ry0nXiWlN0JEYHcUFmD7EV5XtdqSjSUWUTcKCUyi2nLC
         im/9V9PK91WjBZd3qpINyvRaTc9Dx7NyBIHdsrZ4sQdKtRNNhD59Fk1NLqEQW8L0YTO1
         mgAg9I3aHiKnfCLuqQf3m3ZXBNBrqQPyAhN88wB2ViP2usiQbhgsznujGgQjRTj6UyCQ
         D3BIPutJv87De6qlFztccKRM9acwTKJ33s5G+GejpahI5dVmPeMg0SoVGDVDIuT/pWdK
         zn9h86GtkEQ+bNwDFgkCwp6g9T9fSKMOqC7BfSBk7+E6yi1158hdTOzz4dDP6AeLYk1X
         3oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752220155; x=1752824955;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vuj2RXHOOyKDpGAVts46ctP8tG8E0kUzK0aOC3W5/W4=;
        b=pFGlVoOsOb34Ytaig5J+wxvz/otuH6LJBr0rk7927J0I6OI8Hz95IscdiXR9RutiRc
         QGqRLHe+25miuEPSO8M6gd1yX+4QRDspyAhaMmjVUPeKV8KYcOgcDeHUCOmfM9sXKQkO
         gN2xZetHHQlDeHe8vpINYcpu51rumu/xNhUOZeF1vO8D+oqYvprI7l2f5OiP/8Wv0wzq
         Jeq83zoPssDViKVbwaP6v6jlFfaiHJPtT7lGSMq9TejsuhFvHHBIHNtQFQLwQjcFyR2Y
         ryWUmLeu9NI5EFJkWLGT8V7OJTgMol8AlItc5CqlOWPIne2VGGPdSntdJaiZu6crHQkp
         TDbg==
X-Forwarded-Encrypted: i=1; AJvYcCVSRE1a9+5TFtASzXzz7oBvdfhnGOozU1nYxEGvfLinayXx1WYeCisvvjOlEiLmxDr8Doit4UG0D9s6NjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJOoFrfkv3+WVJUdXYv1P1kcoHe+gXlHAs6tqoViCx3x66Mx7
	VtwUy9Q+lnhd2HWu61q6W9JwWalkPP/g/lrhSxDvxfpTmU/ZvVK4pZ/rT0LuunIK4Bw=
X-Gm-Gg: ASbGncvwNeSB+BZCkt98sLM7PIf0JgvuKioa6PnTztri7HSBl0oWoQtEWaJvZhAYBXu
	03SPxwjSftUemx2AoJztK4H++M3w7TA45omif2uW2tzerGfxJeIHOlseVcyNZg2TAzqi0WAX7/Z
	R9FajOo4KnyXzSBNW32fNPbLTdBtCRfnOd/6fFnLqYH1XHsplsAogSPNKlbIEwsia89Th5DWByj
	hrD94FC6+hsaf7IFN4nNJ5ZD/hl4pDe1eNv9fsxwx6MfR0nyG8tUepll6TuuGZbVG9MnqURQn9v
	Tki6xkNk2BAAHVqLaDX4Vd7eLZ+BSexXH9peWfGGXTON2RrYwrl1hzZsWwhmEQNkG8tCezsSTdI
	XxrRCRl/lRVBdy2wwNwK4KXvIxdjwMWWbkcvgaNLSbvet3v71frdz/4tkQFZ3+B2s9XM=
X-Google-Smtp-Source: AGHT+IHF+UIT8lzRUG+Gi81dR379CZsNGMp8TAA1jLven/3EV99Cld3+kcRl0ivBgJtQ89/Q0wzV/w==
X-Received: by 2002:a17:907:e984:b0:ad8:9466:3344 with SMTP id a640c23a62f3a-ae6fc10858fmr222387766b.43.1752220155539;
        Fri, 11 Jul 2025 00:49:15 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264fa0sm248855466b.88.2025.07.11.00.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 00:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 09:49:14 +0200
Message-Id: <DB927EJAGV63.1RSRM7JK907VL@fairphone.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Javier Martinez Canillas"
 <javierm@redhat.com>, "Helge Deller" <deller@gmx.de>,
 <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: simple-framebuffer: Add
 interconnects property
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
 <20250623-simple-drm-fb-icc-v2-1-f69b86cd3d7d@fairphone.com>
 <20250627-mysterious-optimistic-bird-acaafb@krzk-bin>
 <DAX7ZB27SBPV.2Y0I09TVSF3TT@fairphone.com>
 <1129bc60-f9cb-40be-9869-8ffa3b3c9748@kernel.org>
 <8a3ad930-bfb1-4531-9d34-fdf7d437f352@redhat.com>
 <85521ded-734d-48e8-8f76-c57739102ded@kernel.org>
 <e534d496-6ce0-46c8-835d-94b3346446a7@redhat.com>
 <6e4253dd-cd73-4302-b9df-44c8c311eb22@kernel.org>
 <vk7xshncx3vj66ykbt3cfdjwdsx5uewfzlqmfsdbjfgju4awwk@lz76hnenxq2u>
In-Reply-To: <vk7xshncx3vj66ykbt3cfdjwdsx5uewfzlqmfsdbjfgju4awwk@lz76hnenxq2u>

Hi Krzysztof,

On Sun Jul 6, 2025 at 1:24 PM CEST, Dmitry Baryshkov wrote:
> On Wed, Jul 02, 2025 at 10:43:27PM +0200, Krzysztof Kozlowski wrote:
>> On 30/06/2025 10:40, Hans de Goede wrote:
>> >>
>> >> No one asks to drop them from the driver. I only want specific front
>> >> compatible which will list and constrain the properties. It is not
>> >> contradictory to your statements, U-boot support, driver support. I
>> >> really do not see ANY argument why this cannot follow standard DT rul=
es.
>> >=20
>> > So what you are saying is that you want something like:
>> >=20
>> > framebuffer0: framebuffer@1d385000 {
>> > 	compatible =3D "qcom.simple-framebuffer-sm8650-mdss", "simple-framebu=
ffer";
>> > }
>> >=20
>> > and that the binding for qcom.simple-framebuffer-sm8650-mdss
>> > can then list interconnects ?
>> IMO yes (after adjusting above to coding style), but as mentioned in
>> other response you can just get an ack or opinion from Rob or Conor.
>
> But, this way we end up describing MDSS hardware block twice: once with
> the proper device structure and once more in the simple-framebuffer
> definition. I think this is a bit strange.
>
> I understand your point of having a device-specific compatible string
> and also having a verifiable schema, but I think it's an overkill here.
>
> Consider regulator supplies of this simple-framebuffer. Obviously some
> of them supply the panel and not the SoC parts. Should we also include
> the panel into the respective compat string? What about describing the
> device with two different DSI panels?
>
> I think this explodes too quickly to be useful. I'd cast my (small) vote
> into continuing using the simple-framebuffer as is, without additional
> compatible strings and extend the bindings allowing unbound number of
> interconnects.

How do we continue on this?

If the current solution is not acceptable, can you suggest one that is?

I'd like to keep this moving to not block the dts upstreaming
unnecessarily - or otherwise I need to drop simple-framebuffer from the
dts patch and keep this out-of-tree along with a patch like this.

Regards
Luca

